<?php
/**
* @author evilnapsis
* @class NotificationData
* @brief Modelo de base de datos para la tabla de notificaciones
**/
class NotificationData {
	public static $tablename = "notification";


	public function NotificationData(){
		$this->name = "";
		$this->lastname = "";
		$this->email = "";
		$this->password = "";
		$this->created_at = "NOW()";
	}

	public function getUser(){ return UserData::getById($this->user_id); }

	public function add(){
		$sql = "insert into ".self::$tablename." (not_type_id,type_id,ref_id,user_id,author_id,created_at) ";
		echo $sql .= "value ($this->not_type_id,\"$this->type_id\",\"$this->ref_id\",\"$this->user_id\",\"$this->author_id\",NOW())";
		return Executor::doit($sql);
	}

	public function del(){
		$sql = "delete from ".self::$tablename." where id=$this->id";
		Executor::doit($sql);
	}

// partiendo de que ya tenemos creado un objecto NotificationData previamente utilizamos el contexto
	public function update(){
		$sql = "update ".self::$tablename." set name=\"$this->name\" where id=$this->id";
		Executor::doit($sql);
	}

	public static function getById($id){
		$sql = "select * from ".self::$tablename." where id=$id";
		$query = Executor::doit($sql);
		return Model::one($query[0],new NotificationData());
	}

	public static function getByRUT($ref_id,$user_id,$type_id){
		$sql = "select * from ".self::$tablename." where ref_id=$ref_id and user_id=$user_id and type_id=$type_id";
		$query = Executor::doit($sql);
		return Model::one($query[0],new NotificationData());
	}

	public static function countByRT($r,$t){
		$sql = "select count(*) as c from ".self::$tablename." where ref_id=$r and type_id=$t";
		$query = Executor::doit($sql);
		return Model::one($query[0],new NotificationData());
	}


	public static function getAll(){
		$sql = "select * from ".self::$tablename;
		$query = Executor::doit($sql);
		return Model::many($query[0],new NotificationData());
	}
	
	public static function getAllByTR($t,$r){
		$sql = "select * from ".self::$tablename." where type_id=$t and ref_id=$r";
		$query = Executor::doit($sql);
		return Model::many($query[0],new NotificationData());
	}


	public static function getAllByPostId($id){
		$sql = "select * from ".self::$tablename." where post_id=".$id;
		$query = Executor::doit($sql);
		return Model::many($query[0],new NotificationData());
	}


	public static function getLike($q){
		$sql = "select * from ".self::$tablename." where name like '%$q%'";
		$query = Executor::doit($sql);
		return Model::many($query[0],new NotificationData());
	}


}

?>