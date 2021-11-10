<?php
namespace app\admin\controller;
use think\Db;
use \think\Request;
use think\Controller;
use \think\Validate;
use app\admin\model\User;

class Login extends Controller
{	


	/**
	 * 登录界面
	 */
    public function index()
    {  
        $list = db::name("admin")->find();
        //var_dump($list);
        return view();
    }

    /**
     * 登录操作
     */
    public function login(Request $request){
        if ($request->isPost()){
            $all = $request->post();
            $result = $this->validate($all,'app\admin\validate\Login');
            if(true !== $result){
                $this->error($result);
            }

            try {
                $data['username'] = $all['username'];
                $data['password'] = md5($all['password']);

                $result = User::get($data);
            } catch (Exception $e) {
                $this->error($e->getMessage());
            }

            
            if($result){
                session("user",$result);
                $this->success("登录成功");
            }else{
                $this->error("用户名或密码错误");
            }
    	}
    	
    }


     /**
     * 退出登录
     */
    public function logout()
    {
       
        session('user', null);
        session_destroy();
        $this->success('退出登录成功！', '@admin/login');
    }
}
