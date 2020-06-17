<?php
  header('Access-Control-Allow-Origin: http://localhost:8080');
  header('Access-Control-Allow-Credentials: true');
  header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
  header('Access-Control-Max-Age:86400');
  header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token,  Accept, Authorization, X-Requested-With');
  header('Content-Type: application/json');
  include '../config/Database.php';
  include '../models/SessionManager.php';
  session_start();
  
  //check AccessLimit and Referrer
  if(!isset($_SESSION['newSeObj'])){
    $_SESSION['newSeObj'] = new SessionManager();
  }
  if($_SESSION['newSeObj']->userReferrer() == true && 
    $_SESSION['newSeObj']->secLimit() == true &&
    $_SESSION['newSeObj']->dailyLimit() == true){
    // echo 'ok';
  } else {
    http_response_code(401);
    echo json_encode(
      array('message' => 'Denied.')
    );
    die();
  }
  //connect to database
  include '../models/Recipe.php';
  $database = new Database();
  $db = $database->connect();
  $recipe = new Recipe($db);
  if(isset($_GET['method'])){
    switch($_GET['method']){
      case 'rrecipe':
      if(isset($_GET['id'])){
        $id = $_GET['id'];
        $result = $recipe->read_single($id);
      } else {
        $result = $recipe->getRecipe();
      }

      $num = $result->rowCount();

      if($num > 0){
        $i = 0 ;
        //Post array
        $recipes_arr = array();
        $recipes_arr['data'] = array();
        $ingre_arr = array();
        $step_arr = array();
        $comm_arr = array();
    
        // getRecipe
        while($row = $result->fetch(PDO::FETCH_ASSOC)){
          extract($row);
          $recipe_info = array(
            'recipe_id' => $recipe_id,
            'name' => $name,
            'description' => $description,
            'imgUrl' => $imgUrl,
            'thumbsUp' => $thumbsUp,
            'user_id' => $user_id,
            'username' => $username,
            'ingre_arr' => $ingre_arr,
            'step_arr'=> $step_arr,
            'comm_arr' => $comm_arr
          );
          
          array_push($recipes_arr['data'], $recipe_info);
    
          //get Ingredients
          $ingreResult = $recipe->getIngre((int)$recipe_id);
          $ingreNum = $ingreResult->rowCount();
    
          if($ingreNum>0){
            while($ingreRow = $ingreResult->fetch(PDO::FETCH_ASSOC)){
              array_push($recipes_arr['data'][$i]['ingre_arr'], $ingreRow);
            };
          }
          
          //get step
          $stepResult = $recipe->getStep((int)$recipe_id);
          $stepNum = $stepResult->rowCount();
    
          if($stepNum>0){
            while($stepRow = $stepResult->fetch(PDO::FETCH_ASSOC)){
              array_push($recipes_arr['data'][$i]['step_arr'], $stepRow);
            };
          }
          
          $commResult = $recipe->getComment((int)$recipe_id);
          $commNum = $commResult->rowCount();
    
          if($commNum>0){
            while($commRow = $commResult->fetch(PDO::FETCH_ASSOC)){
    
              array_push($recipes_arr['data'][$i]['comm_arr'], $commRow);
            };
          }
          $i++;
        };
        //Trun to JSON & output
        echo json_encode($recipes_arr);
      } else {
        http_response_code(404);
        //No posts
        echo json_encode(
          array('message' => 'No Posts Found')
        );
      }

      break;
      case 'register':
        $data = json_decode(file_get_contents("php://input"));
        if (strlen($data->username) > 4 && 
            strlen($data->username) < 16 &&
            strlen($data->password) > 7 && 
            strlen($data->password) < 81){
          $recipe->username = $data->username;
          $recipe->password = $data->password;
          $recipe->privilege = 2;
        } else {
          http_response_code(401);
          echo json_encode(
            array('message' => 'unauthorized')
          );
          $recipe->logging('register', 'fail');
          return ;
        }

        if($recipe->createUser()){
          $recipe->logging('register', 'success');
          echo json_encode(
            array('message' => 'Welcome!')
          );
        } else {
          $recipe->logging('register', 'fail');
          http_response_code(409);
          echo json_encode(
            array('message' => 'Username already exist.')
          );
        }
      break;
      case 'login':
        $data = json_decode(file_get_contents("php://input"));
        if (strlen($data->username) > 4 && 
            strlen($data->username) < 16 &&
            strlen($data->password) > 7 && 
            strlen($data->password) < 81){
          $recipe->username = $data->username;
          $recipe->password = $data->password;
        } else {
          http_response_code(401);
          echo json_encode(
            array('message' => 'unauthorized')
          );
          return;
        }
        if($recipe->validateUser()){
          $recipe->logging('login', 'success');
          echo json_encode(
            array('message' => 'Welcome back!',
                  'privilege' => $_SESSION['privilege'],
                  'user_id' => $_SESSION['user_id'],
                  'username' => $_SESSION['username'])
          );
        } else {
          $recipe->logging('login', 'fail');
          http_response_code(401);
          echo json_encode(
            array('message' => 'Wrong Combination.')
          );
        }
      break;
      case 'logout':
        unset($_SESSION['username']);
        unset($_SESSION['user_id']);
        unset($_SESSION['privilege']);
        unset($_SESSION['logged_in']);
        $recipe->logging('logout', 'success');
        echo json_encode(
          array('message' => 'Logged Out')
        );
        // echo  $_SESSION['username'];
        // echo $_SESSION['user_id'];
        // echo $_SESSION['privilege'];
        // echo $_SESSION['logged_in'];
        // session_destroy();
      break;
      case 'crecipe':
        if(isset($_SESSION['logged_in'])){
          $data = json_decode(file_get_contents("php://input"));
          $allGood = true;
          if(strlen($data->name) < 2 || strlen($data->name) > 30){
            $allGood = false;
          }
          if(strlen($data->description) < 15 || strlen($data->description) > 600){
            $allGood = false;
          }
          $recipe->name = $data->name;
          $recipe->description = $data->description;
          $recipe->imgUrl = $data->imgUrl;
          $recipe->user_id = $_SESSION['user_id'];
          
          for($i = 0; $i < 15; $i++){
            if (!empty($data->quantity[$i]) && !empty($data->measurement[$i]) && !empty($data->item[$i])) {
              if (!ctype_digit($data->quantity[$i]) ||
                  !ctype_digit($data->measurement[$i]) ||
                  strlen($data->item[$i]) < 2 ||
                  strlen($data->item[$i]) > 50) {
                $allGood = false;
              }
              $recipe->quantity[$i] = $data->quantity[$i];
              $recipe->measurement[$i] = $data->measurement[$i];
              $recipe->item[$i] = $data->item[$i];
            }
          }

          for($i = 0; $i < 5; $i++){
            if(!empty($data->step[$i])){
              if(strlen($data->step[$i]) < 15 || strlen($data->step[$i]) > 200) {
                $allGood = false;
              }
              $recipe->step[$i] = $data->step[$i];
            }
          }
          if(!$allGood) {
            $recipe->logging('create recipe', 'fail');
            http_response_code(501);
            echo json_encode(
              array('message' => 'not authorized')
            );
            return;
          }

          if($recipe->createRecipe()){
            $recipe->logging('create recipe', 'success');
            echo json_encode(
              array('message' => 'Created!',
                    'recipe_id' => $_SESSION['myLastRecipe'])
            );
            unset($_SESSION['myLastRecipe']);
          } else {
            $recipe->logging('create recipe', 'fail');
            http_response_code(501);
            echo json_encode(
              array('message' => 'Recipe not added')
            );
          }
        } else {
          $recipe->logging('create recipe', 'fail');
          //if user is not logged in
          http_response_code(403);
          echo json_encode(
            array('message' => 'Access denied')
          );
        }
      break;
      case 'drecipe':
        if(isset($_GET['id']) && isset($_SESSION['logged_in'])){
          if(!ctype_digit($_GET['id'])){
            http_response_code(501);
            $recipe->logging('delete recipe', 'fail');
            echo json_encode(
              array('message' => 'not authorized')
            );
            return;
          }
          if(
            //if the logged in user own the recipe
            $recipe->checkRecipeOwnership($_GET['id']) == $_SESSION['user_id'] ||
            // or the logged in user have admin privilege
            $_SESSION['privilege'] == 1){
              
            $data = json_decode(file_get_contents("php://input"));

            $recipe->recipe_id = $_GET['id'];
            //delete recipe
            if($recipe->deleteRecipe()){
              $recipe->logging('delete recipe', 'success');
              echo json_encode(
                array('message' => 'Deleted.')
              );
            } else {
              //if somehow the user own the recipe cannot delete it
              $recipe->logging('delete recipe', 'fail');
              echo json_encode(
                array('message' => 'Recipe not delete')
              );
            }
            
          } else {
            //if logged in but user does not own the recipe
            $recipe->logging('delete recipe', 'fail');
            http_response_code(403);
            echo json_encode(
              array('message' => 'Access denied')
            );
          }

        } else {
          //if get access to delete recipe but not logged in
          $recipe->logging('delete recipe', 'fail');
          http_response_code(401);
          echo json_encode(
            array('message' => 'Not authorized.')
          );
        }
      break;
      case 'urecipe':
        if(isset($_GET['id']) && isset($_SESSION['logged_in'])){
          if(ctype_digit($_GET['id']) &&
          //if the logged in user own the recipe
          $recipe->checkRecipeOwnership($_GET['id']) == $_SESSION['user_id'] ||
          // or the logged in user have admin privilege
          $_SESSION['privilege'] == 1){
            $data = json_decode(file_get_contents("php://input"));
            $allGood = true;
            if(strlen($data->name) < 2 || strlen($data->name) > 30){
              $allGood = false;
            }
            if(strlen($data->description) < 15 || strlen($data->description) > 600){
              $allGood = false;
            }
            $recipe->name = $data->name;
            $recipe->description = $data->description;
            $recipe->imgUrl = $data->imgUrl;  
            $recipe->recipe_id = $_GET['id'];
            
            for($i = 0; $i < 15; $i++){
              if(!empty($data->quantity[$i]) &&
                !empty($data->measurement[$i]) &&
                !empty($data->item[$i]) &&
                !empty($data->i_id[$i])){
                if (!ctype_digit($data->quantity[$i]) ||
                    !ctype_digit($data->measurement[$i]) ||
                    strlen($data->item[$i]) < 2 ||
                    strlen($data->item[$i]) > 50) {
                    $allGood = false;
                }
                $recipe->quantity[$i] = $data->quantity[$i];
                $recipe->measurement[$i] = $data->measurement[$i];
                $recipe->item[$i] = $data->item[$i];
                $recipe->i_id[$i] = $data->i_id[$i];
              }
            }
  
            for($i = 0; $i < 5; $i++){
              if(!empty($data->step[$i]) && !empty($data->met_id[$i])){
                if(strlen($data->step[$i]) < 15 || strlen($data->step[$i]) > 200) {
                  $allGood = false;
                }
                $recipe->step[$i] = $data->step[$i];
                $recipe->met_id[$i] = $data->met_id[$i];
              }
            }
            if(!$allGood) {
              $recipe->logging('update recipe', 'fail');
              http_response_code(501);
              echo json_encode(
                array('message' => 'not authorized')
              );
              die();
            }

            if($recipe->updateRecipe()){
              $recipe->logging('update recipe', 'success');
              echo json_encode(
                array('message' => 'Updated!')
              );
            } else {
              $recipe->logging('update recipe', 'fail');
              echo json_encode(
                array('message' => 'Recipe NOT updated')
              );
            }
            
          } else {
            //if logged in but user does not own the recipe
            $recipe->logging('update recipe', 'fail');
            http_response_code(403);
            echo json_encode(
              array('message' => 'Access denied')
            );
          }

        } else {
          //if get access to delete recipe but not logged in
          $recipe->logging('update recipe', 'fail');
          http_response_code(401);
          echo json_encode(
            array('message' => 'Not authorized.')
          );
        }
      break;
      case 'ccomment':
        if(isset($_GET['id']) && isset($_SESSION['logged_in'])){
          $data = json_decode(file_get_contents("php://input"));
          if(!ctype_digit($_GET['id']) || strlen($data->content) < 5 || strlen($data->content) > 30){
            $recipe->logging('create comment', 'fail');
            http_response_code(501);
            echo json_encode(
              array('message' => 'not authorized')
            );
            return;
          }
          $recipe->recipe_id = $_GET['id'];
          $recipe->content = $data->content;
          $recipe->user_id = $_SESSION['user_id'];
        
          if($recipe->createComment()){
            $recipe->logging('create comment', 'success');
            echo json_encode(
              array('message' => 'Comment Added',
                    'c_id' => $_SESSION['myLastInsertComment'])
            );
            unset($_SESSION['myLastInsertComment']);
          } else {
            $recipe->logging('create comment', 'fail');
            http_response_code(403);
            echo json_encode(
              array('message' => 'Comment not added')
            );
          }

        } else {
          //if get access to delete recipe but not logged in
          $recipe->logging('create comment', 'fail');
          http_response_code(401);
          echo json_encode(
            array('message' => 'Not authorized.')
          );
        }
      break;
      case 'dcomment':
        if(isset($_GET['id']) && isset($_SESSION['logged_in'])){
          $data = json_decode(file_get_contents("php://input"));
          if(ctype_digit($_GET['id']) && ctype_digit($data->c_id) &&
            //if the logged in user own the comment
            $recipe->checkCommentOwnership($data->c_id) == $_SESSION['user_id'] ||
            // or the logged in user have admin privilege
            $_SESSION['privilege'] == 1){

            $recipe->c_id = $data->c_id;
          
            if($recipe->deleteComment()){
              $recipe->logging('delete comment', 'success');
              echo json_encode(
                array('message' => 'Deleted.')
              );
            } else {
              $recipe->logging('delete comment', 'fail');
              echo json_encode(
                array('message' => 'Comment not Delete')
              );
            }
            
          } else {
            $recipe->logging('delete comment', 'fail');
            //if logged in but user does not own the recipe
            http_response_code(403);
            echo json_encode(
              array('message' => 'Access denied')
            );
          }

        } else {
          //if get access to delete recipe but not logged in
          http_response_code(401);
          echo json_encode(
            array('message' => 'Not authorized.')
          );
        }
      break;
      case 'search':
        if(isset($_GET['searchfield'])){
          $recipe->searchItem = $_GET['searchfield'];
          $searchResult = $recipe->searchCocktail();
          $searchNum = $searchResult->rowCount();
          if($searchNum > 0){
            $i = 0 ;
            //Post array
            $recipes_arr = array();
            $recipes_arr['data'] = array();
            $ingre_arr = array();
            $step_arr = array();
            $comm_arr = array();

            while($searchRow = $searchResult->fetch(PDO::FETCH_ASSOC)){
              extract($searchRow);
              // echo $searchRow['recipe_id'];
              $result = $recipe->read_single($searchRow['recipe_id']);
              //////////////////////////////////////
              while($row = $result->fetch(PDO::FETCH_ASSOC)){
                extract($row);
                $recipe_info = array(
                  'recipe_id' => $recipe_id,
                  'name' => $name,
                  'description' => $description,
                  'imgUrl' => $imgUrl,
                  'user_id' => $user_id,
                  'username' => $username,
                  'thumbsUp' => $thumbsUp,
                  'ingre_arr' => $ingre_arr,
                  'step_arr'=> $step_arr,
                  'comm_arr' => $comm_arr
                );
                
                array_push($recipes_arr['data'], $recipe_info);
          
                //get Ingredients
                $ingreResult = $recipe->getIngre((int)$recipe_id);
                $ingreNum = $ingreResult->rowCount();
          
                if($ingreNum>0){
                  while($ingreRow = $ingreResult->fetch(PDO::FETCH_ASSOC)){
                    array_push($recipes_arr['data'][$i]['ingre_arr'], $ingreRow);
                  };
                }
                
                //get step
                $stepResult = $recipe->getStep((int)$recipe_id);
                $stepNum = $stepResult->rowCount();
          
                if($stepNum>0){
                  while($stepRow = $stepResult->fetch(PDO::FETCH_ASSOC)){
                    array_push($recipes_arr['data'][$i]['step_arr'], $stepRow);
                  };
                }
                
                $commResult = $recipe->getComment((int)$recipe_id);
                $commNum = $commResult->rowCount();
          
                if($commNum>0){
                  while($commRow = $commResult->fetch(PDO::FETCH_ASSOC)){
                    array_push($recipes_arr['data'][$i]['comm_arr'], $commRow);
                  };
                }
              };
              $i++;
              ////////////////////////////////////////
            }
            echo json_encode($recipes_arr);
          } else {
            http_response_code(404);
            //No posts
            echo json_encode(
              array('message' => 'No Posts Found')
            );
          }
        }
      break;
      case 'like':
        if(isset($_GET['id'])){
            if($recipe->like($_GET['id'])){
              echo json_encode(
                array('message' => 'Liked!')
              );
            } else {
              echo json_encode(
                array('message' => 'not liked')
              );
            }
        } else {
          //if get access to delete recipe but not logged in
          http_response_code(401);
          echo json_encode(
            array('message' => 'Not authorized.')
          );
        }
      break;
      case 'admindelete':
        if(isset($_GET['id']) && $_SESSION['privilege'] == 1){
          if($recipe->deleteAllbyUserId($_GET['id'])){
            $recipe->logging('admin delete', 'success');
            echo json_encode(
              array('message' => 'delete ALL!')
            );
          } else {
            $recipe->logging('admin delete', 'fail');
            echo json_encode(
              array('message' => 'not delete ALL')
            );
          }
      } else {
        //if get access to delete recipe but not logged in
        $recipe->logging('admin delete', 'fail');
        http_response_code(401);
        echo json_encode(
          array('message' => 'Not authorized.')
        );
      }
      break;
      default:
        http_response_code(404);
        echo json_encode(
          array('message' => 'Page not found.')
        );
    }
  }
