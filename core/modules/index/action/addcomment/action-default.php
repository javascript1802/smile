<?php
/**
* @author evilnapsis
* @brief Agregar likes apartir del id y tipo de referencia con el usuario logeado.
**/
if(Session::exists("user_id") && !empty($_POST)){
	if($_POST["content"]!=""){
	$h = new CommentData();
	$h->ref_id = $_POST["r"];
	$h->user_id = $_SESSION["user_id"];
	$h->type_id = $_POST["t"];
	$h->content = $_POST["content"];
	$h->add();

	$user_id = null;
	if($_POST["t"]==1){
	$post = PostData::getReceptorId($_POST["r"]);
	$user_id = $post->receptor_ref_id;
	}
//	print_r($_)

	$notification = new NotificationData();
	$notification->not_type_id=2; // comment
	$notification->type_id = $_POST["t"]; // al mismo que nos referenciamos en al crear el comentario
	$notification->ref_id = $_POST["r"]; // =
	$notification->user_id = $user_id; // en este caso nos referimos a quien va dirigida la notificacion
	$notification->author_id = $_SESSION["user_id"]; // ahora al usuario implicado
	$notification->add();


	}
}

?>
