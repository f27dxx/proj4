<?php
  class SessionManager {

    public function dailyLimit(){
      if(!isset($_SESSION['accessCount'])){
        $_SESSION['accessCount'] = 0;
      }
      $_SESSION['accessCount']++;
      //get current time
      $_SESSION['currentTime'] = new DateTime();
      //start count 24 hours
      if(!isset($_SESSION['firstAccess'])){
        $_SESSION['firstAccess'] = new DateTime();
      }
      if(isset($_SESSION['firstAccess'])){
        //calculate the difference btw current time and the firstAccess time
        $diff = $_SESSION['currentTime']->diff($_SESSION['firstAccess']);
        //if the difference greater or equal than 1 day
        if($diff->d >= 1){
          //reset 24 hours counter
          unset($_SESSION['firstAccess']);
          //reset access counter
          unset($_SESSION['accessCount']);
        }
        //if access count greater or equal to 500 return false
        if(isset($_SESSION['accessCount']) && $_SESSION['accessCount'] >= 500){
          return false; 
        }
        return true;
      }
    }

    public function secLimit(){
      date_default_timezone_set ('Australia/Brisbane');

      if (isset($_SESSION['LAST_CALL'])) {
        $last = strtotime($_SESSION['LAST_CALL']);
        $curr = strtotime(date("Y-m-d h:i:s"));
        $sec =  abs($last - $curr);
        if ($sec < 1) {
        return false;      
        }
      }
      $_SESSION['LAST_CALL'] = date("Y-m-d H:i:s");

      return true;
    }

    public function userReferrer(){
      $whitelist = array(
        '127.0.0.1',
        '::1'
      );
    
      if(!in_array($_SERVER['REMOTE_ADDR'], $whitelist)){
        return false;
      }
      
      return true;
    }


  }

?>