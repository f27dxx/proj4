<?php
  class Recipe {
    //DB stuff
    private $conn;
    private $table = 'recipe';

    //recipe Properties
    public $recipe_id;
    public $name;
    public $description;
    public $user_id;
    public $quantity;
    public $measurement;
    public $item;
    public $imgUrl;
    public $content;
    public $thumbsUp;

    //Construstor with DB
    public function __construct($db){
      $this->conn = $db;
    }

    //Get Recipe
    public function getRecipe(){
      //Query
      $query = 'SELECT r.*, l.username FROM recipe r
                JOIN login l
                where l.user_id = r.user_id
                ORDER BY thumbsUp DESC';
      //Prepare statment
      $stmt = $this->conn->prepare($query);
      //Execute query
      $stmt->execute();
      return $stmt;
    }

    //get ingredients
    public function getIngre($recipe_id){
      // $query = 'SELECT CONCAT(i.quantity, " ", m.type, " " ,i.item) AS ingredients
      $query = 'SELECT i.i_id, i.quantity, m.type, i.item, i.measurement
                FROM recipe r 
                JOIN ingredient i on i.recipe_id = r.recipe_id 
                JOIN measurement m on m.mea_id = i.measurement 
                WHERE r.recipe_id =' . $recipe_id ;
      //Prepare statment
      $stmt = $this->conn->prepare($query);
      //Execute query
      $stmt->execute();
      return $stmt;
    }

    //get step
    public function getStep($recipe_id){
      //Query
      $query = 'SELECT  m.met_id, m.step
      FROM recipe r 
      JOIN method m on m.recipe_id = r.recipe_id 
      WHERE r.recipe_id = ' . $recipe_id ;
      //Prepare statment
      $stmt = $this->conn->prepare($query);
      //Execute query
      $stmt->execute();
      return $stmt;
    }

    //get comment
    public function getComment($recipe_id){
      $query = 'SELECT c.c_id, c.content, l.username 
                FROM comment c
                JOIN login l on c.user_id = l.user_id
                WHERE recipe_id = ' . $recipe_id;
      $stmt = $this->conn->prepare($query);
      $stmt->execute();
      return $stmt;
    }

    //get single post
    public function read_single($id){
      $query = 'SELECT r.*, l.username FROM recipe r
                JOIN login l
                where l.user_id = r.user_id and recipe_id = ' .$id ;
      $stmt = $this->conn->prepare($query);
      //execute query
      $stmt->execute();
      return $stmt;
    }

    //create recipe
    public function createRecipe(){
      $this->conn->beginTransaction();

      //insert to recipe
      $query = 'INSERT INTO recipe 
              SET
              name = :name,
              description = :description,
              imgUrl = :imgUrl,
              user_id = :user_id';

      //prepate statement
      $stmt = $this->conn->prepare($query);

      //input filter
      $this->name = htmlspecialchars(strip_tags($this->name));
      $this->description = htmlspecialchars(strip_tags($this->description));
      $this->imgUrl = htmlspecialchars(strip_tags($this->imgUrl));
      $this->user_id = htmlspecialchars(strip_tags($this->user_id));

      //bind data
      $stmt->bindParam(':name', $this->name);
      $stmt->bindParam(':description', $this->description);
      $stmt->bindParam(':imgUrl', $this->imgUrl);
      $stmt->bindParam(':user_id', $this->user_id);
      $stmt->execute();
      
      //get the recipeID
      $lastRecipeId = $this->conn->lastInsertId();

      //insert into ingredients
      for($i = 0; $i < 15; $i++){
        if(!empty($this->quantity[$i]) && !empty($this->measurement[$i]) && !empty($this->item[$i])){
          $query = 'INSERT INTO ingredient
                  SET
                  recipe_id = :recipe_id,
                  quantity = :quantity,
                  measurement = :measurement,
                  item = :item';
  
          $stmt = $this->conn->prepare($query);
  
          //input filter
          $this->quantity[$i] = htmlspecialchars(strip_tags($this->quantity[$i]));
          $this->measurement[$i] = htmlspecialchars(strip_tags($this->measurement[$i]));
          $this->item[$i] = htmlspecialchars(strip_tags($this->item[$i]));
  
          //bind data
          $stmt->bindValue(':recipe_id', $lastRecipeId);
          $stmt->bindParam(':quantity', $this->quantity[$i]);
          $stmt->bindParam(':measurement', $this->measurement[$i]);
          $stmt->bindParam(':item', $this->item[$i]);
          $stmt->execute();
        }
      }

      // //insert into method
      for($i = 0; $i < 5; $i++){
        if( !empty($this->step[$i]) ){
          $query = 'INSERT INTO method
                    SET
                    recipe_id = :recipe_id,
                    step = :step';
          $stmt = $this->conn->prepare($query);
          //filter
          $this->step[$i] = htmlspecialchars(strip_tags($this->step[$i]));
          //bind value
          $stmt->bindValue(':recipe_id', $lastRecipeId);
          $stmt->bindParam(':step', $this->step[$i]);
          $stmt->execute();
        }
      }

      //save into database
      if($this->conn->commit()){
        $_SESSION['myLastRecipe'] = $lastRecipeId;
        return true;
      }
      //print error if something goes wrong
      printf('Error: %s.\n', $stmt->error);
      return false;
    }

    //update recipe
    public function updateRecipe(){
      $this->conn->beginTransaction();

      //update recipe
      $query = 'UPDATE recipe 
                SET
                name = :name,
                description = :description,
                imgUrl = :imgUrl
                WHERE recipe_id = :recipe_id';
      //prepate statement
      $stmt = $this->conn->prepare($query);
      //input filter
      $this->name = htmlspecialchars(strip_tags($this->name));
      $this->description = htmlspecialchars(strip_tags($this->description));
      $this->imgUrl = htmlspecialchars(strip_tags($this->imgUrl));
      $this->recipe_id = htmlspecialchars(strip_tags($this->recipe_id));
      //bind data
      $stmt->bindParam(':name', $this->name);
      $stmt->bindParam(':description', $this->description);
      $stmt->bindParam(':imgUrl', $this->imgUrl);
      $stmt->bindParam(':recipe_id', $this->recipe_id);
      $stmt->execute();
      
      //update ingredients
      for($i=0;$i<15;$i++){
        if(!empty($this->quantity[$i]) &&
          !empty($this->measurement[$i]) &&
          !empty($this->item[$i]) &&
          !empty($this->i_id[$i])){
          $query = 'UPDATE ingredient
                    SET
                    quantity = :quantity,
                    measurement = :measurement,
                    item = :item
                    WHERE i_id = :i_id';
          $stmt = $this->conn->prepare($query);
          //input filter
          $this->quantity[$i] = htmlspecialchars(strip_tags($this->quantity[$i]));
          $this->measurement[$i] = htmlspecialchars(strip_tags($this->measurement[$i]));
          $this->item[$i] = htmlspecialchars(strip_tags($this->item[$i]));
          $this->i_id[$i] = htmlspecialchars(strip_tags($this->i_id[$i]));
          //bind data
          $stmt->bindParam(':quantity', $this->quantity[$i]);
          $stmt->bindParam(':measurement', $this->measurement[$i]);
          $stmt->bindParam(':item', $this->item[$i]);
          $stmt->bindParam(':i_id', $this->i_id[$i]);
          $stmt->execute();
        }
      }
      ///////////////////////////method/////////////////////////////
      for($i=0; $i<5; $i++){
        if(!empty($this->step[$i]) && !empty($this->met_id[$i])){
          $query = 'UPDATE method
          SET
          step = :step
          WHERE met_id = :met_id';
          $stmt = $this->conn->prepare($query);
          //input filter
          $this->step[$i] = htmlspecialchars(strip_tags($this->step[$i]));
          $this->met_id[$i] = htmlspecialchars(strip_tags($this->met_id[$i]));
          //bind data
          $stmt->bindParam(':step', $this->step[$i]);
          $stmt->bindParam(':met_id', $this->met_id[$i]);
          $stmt->execute();
        }
      }
    //save into database
      // $conn->commit();
      if($this->conn->commit()){
        return true;
      }
      //print error if something goes wrong
      printf('Error: %s.\n', $stmt->error);
      return false;
    }

    public function deleteRecipe(){
      $this->conn->beginTransaction();
      //delete from method (step)
      $query = 'DELETE FROM method
                WHERE recipe_id = :recipe_id';
      $stmt = $this->conn->prepare($query);
      //input filter
      $this->recipe_id = htmlspecialchars(strip_tags($this->recipe_id));
      //bind data
      $stmt->bindParam(':recipe_id', $this->recipe_id);
      $stmt->execute();

      //delete from ingredients
      $query = 'DELETE FROM ingredient
                WHERE recipe_id = :recipe_id';
      $stmt = $this->conn->prepare($query);
      //input filter
      $this->recipe_id = htmlspecialchars(strip_tags($this->recipe_id));
      //bind data
      $stmt->bindParam(':recipe_id', $this->recipe_id);
      $stmt->execute();
     
      //delete comment
      $query = 'DELETE FROM comment
                WHERE recipe_id = :recipe_id';
      $stmt = $this->conn->prepare($query);
      $this->recipe_id = htmlspecialchars(strip_tags($this->recipe_id));
      $stmt->bindParam(':recipe_id', $this->recipe_id);
      $stmt->execute();

      //finally delete recipe
      $query = 'DELETE FROM recipe 
                WHERE recipe_id = :recipe_id';
      //prepate statement
      $stmt = $this->conn->prepare($query);
      //input filter
      $this->recipe_id = htmlspecialchars(strip_tags($this->recipe_id));
      //bind data
      $stmt->bindParam(':recipe_id', $this->recipe_id);
      $stmt->execute();

      if($this->conn->commit()){
        return true;
      }

      //print error if something goes wrong
      printf('Error: %s.\n', $stmt->error);

      return false;
    
    }

    public function createComment(){
      if( !empty($this->recipe_id) && !empty($this->content) && !empty($this->user_id) ){
        //insert to recipe
        $query = 'INSERT INTO comment 
                SET
                recipe_id = :recipe_id,
                content = :content,
                user_id = :user_id';

        //prepate statement
        $stmt = $this->conn->prepare($query);

        //input filter
        $this->recipe_id = htmlspecialchars(strip_tags($this->recipe_id));
        $this->content = htmlspecialchars(strip_tags($this->content));
        $this->user_id = htmlspecialchars(strip_tags($this->user_id));
        //bind data
        $stmt->bindParam(':recipe_id', $this->recipe_id);
        $stmt->bindParam(':content', $this->content);
        $stmt->bindParam(':user_id', $this->user_id);
        
        //save into database
        if($stmt->execute()){
          $lastRecipeId = $this->conn->lastInsertId();
          $_SESSION['myLastInsertComment'] = $lastRecipeId;
          return true;
        }
      }
      return false;
    }

    public function deleteComment(){
      $query = 'DELETE FROM comment
                WHERE c_id = :c_id';
      $stmt = $this->conn->prepare($query);
      //input filter
      $this->c_id = htmlspecialchars(strip_tags($this->c_id));
      //bind data
      $stmt->bindParam(':c_id', $this->c_id);
      if($stmt->execute()){
        return true;
      }
      //print error if something goes wrong
      // printf('Error: %s.\n', $stmt->error);
      return false;
    }

    public function createUser(){
      $query = 'SELECT username FROM login
                WHERE username = :username';
      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':username', $this->username);
      $stmt->execute();
      if($stmt->rowCount()<1) {
        $query = 'INSERT INTO login
        SET
        username = :username,
        password = :password,
        privilege = :privilege';
        $stmt = $this->conn->prepare($query);

        //encrypt
        $this->password = password_hash($this->password, PASSWORD_DEFAULT);
        $stmt->bindParam(':username', $this->username);
        $stmt->bindParam(':password', $this->password);
        $stmt->bindParam(':privilege', $this->privilege);

        if($stmt->execute()){
        return true;
        }
        //print error if something goes wrong
        // printf('Error: %s.\n', $stmt->error);
        return false;
      }
    }

    public function validateUser(){
      $query = 'SELECT user_id, username, password, privilege
                FROM login
                WHERE username = :username';

      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':username', $this->username);
      $stmt->execute();
      if($stmt->rowCount() > 0 ){
        $row = $stmt->fetch();
        // $password = $this->password;
        if(password_verify($this->password, $row['password'])) {
          // assign session variables
          $_SESSION['username'] = $this->username;
          $_SESSION['user_id'] = $row['user_id'];
          $_SESSION['privilege'] = $row['privilege'];
          $_SESSION['logged_in'] = true;
          // echo  $_SESSION['username'];
          // echo $_SESSION['user_id'];
          // echo $_SESSION['privilege'];
          // echo $_SESSION['logged_in'];
          return true;
        }
      }
      // printf('Error: %s.\n', $stmt->error);
      return false;
    }

    public function checkRecipeOwnership($id){
      $query = 'SELECT user_id FROM recipe
                WHERE recipe_id = :recipe_id';
      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':recipe_id', $id);
      $stmt->execute();
      $row = $stmt->fetch();
      // echo $row['user_id'];
      return $row['user_id'];
    }

    public function checkCommentOwnership($id){
      $query = 'SELECT user_id FROM comment
                WHERE c_id = :c_id';
      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':c_id', $id);
      $stmt->execute();
      $row = $stmt->fetch();
      // echo $row['user_id'];
      return $row['user_id'];
    }

    public function searchCocktail(){
      $query = 'SELECT recipe_id FROM recipe
                WHERE name LIKE :name
                ORDER BY thumbsUp DESC';

      $this->searchItem = '%'.$this->searchItem.'%';
      //Prepare statment
      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':name', $this->searchItem);
      //Execute query
      $stmt->execute();
      if($stmt->rowCount() > 0){
        return $stmt;
      }

      $query = 'SELECT DISTINCT r.thumbsUp, i.recipe_id FROM ingredient i
                JOIN recipe r
                WHERE item LIKE :item and i.recipe_id = r.recipe_id
                ORDER BY thumbsUp DESC';

      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':item', $this->searchItem);
      //Execute query
      $stmt->execute();
      return $stmt;
    }

    public function like($id){
      $num;
      $query = 'SELECT thumbsUp FROM recipe
                WHERE recipe_id = :recipe_id';
      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':recipe_id', $id);
      $stmt->execute();
      $row = $stmt->fetch();
      $num = $row['thumbsUp'] + 1;

      $query = 'UPDATE recipe 
                SET
                thumbsUp = :thumbsUp
                WHERE recipe_id = :recipe_id';
      $stmt = $this->conn->prepare($query);
      $stmt->bindParam(':recipe_id', $id);
      $stmt->bindParam(':thumbsUp', $num);
      if($stmt->execute()){
        return true;
      } else {
        return false;
      }
    }
  }
