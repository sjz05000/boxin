<?php
namespace app\admin\controller;
use think\Db;
use think\Controller;
class Login extends Controller
{	


	/**
	 * 登录界面
	 */
    public function index()
    {
        return view();
    }

    /**
     * 登录操作
     */
    public function login(Requset $request){
        if (Request::instance()->isPost()){
        $result = $this->validate($request->all(),'app\admin\validate\Login.dologin');
        if(true !== $result){
            $this->error($result);
        }
    		$all = $request->all();
            print_r($all);
    	}
    	
    }
}
