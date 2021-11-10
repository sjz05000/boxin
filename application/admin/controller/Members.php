<?php
namespace app\admin\controller;
use think\Db;
use think\Controller;
use app\admin\model\Member;

class Members extends Base{

	public function index(){
		return view();
	}

	public function list(){
		$list = Member::where('1=1')->paginate(10);
		// 把分页数据赋值给模板变量list
		$this->assign('list', $list);
		return view("index");
	}
}