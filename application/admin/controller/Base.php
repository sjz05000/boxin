<?php 
namespace app\admin\controller;
use think\Db;
use \think\Request;
use think\Controller;


class Base extends Controller{

	public function initialize(){
		if(!session("user")){
				$this->redirect("/admin/login");
		}
		parent::initialize();
	}

	
}
