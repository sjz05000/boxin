<?php

namespace app\common\controller;

use think\Controller;
use Firebase\JWT\JWT;
use app\common\model\User;

// c 端接口基础方法
class Base extends Controller
{
    public $param = [];
    public $model = null;
    public $controller = null;
    public $action = null;
    public $mvc = null;
    public $user_id = null;
    public $controllers = null;

    /**
     * token验证 tp6 initialize()  tp5.1 initialize() tp5.0 _initialize()
     */
    protected function initialize()
    {
        //保存参数
        $this->setAction();

        //不需要Token验证的控制器
        $controller = [
            'capi/Login',   // 登录
            'capi/Upload',  // 上传文件
        ];

        //不需要 Token 验证的方法
        $ext = [
            'capi/Home/ranking_list',  // 首页-轮播排行榜
        ];
        if(!in_array($this->controllers, $controller)){
            if (!in_array($this->mvc, $ext)) {
                //token验证
                $check = $this->checkToken();
                if ($check === false) {
                    $this->result([],400,'您还没有登录！');
                }
                $user = new User();
                $info = $user->getInfo(['id' => $this->user_id]);
                if(empty($info['data'])){
                    $this->result([],400,'用户不存在！');
                }
            }
        }
    }

    /**
     * 接收数据
     */
    private function setAction()
    {
        $this->model = request()->module();
        $this->controller = request()->controller();
        $this->action = request()->action();
        $this->mvc = $this->model . "/" . $this->controller . "/" . $this->action;
        $this->controllers = $this->model . "/" . $this->controller;
        $this->param = request()->isPost() ? input('post.') : input('get.');
    }


    /**
     * Token 校验
     * @return bool
     */
    private function checkToken()
    {
        //获取 JWT 密钥
        $key = 'wdfs32424XCVEs32CVX465484';

        //判断 Token 是否存在
        if (!isset($this->param['token']) || $this->param['token'] == null) {
            return false;
        }
        //解密 JWT 字符串
        $param_decode = JWT::decode($this->param['token'], $key, array('HS256'));
        $param_decode = (array)$param_decode;

        //判断 user_id 是否存在
        if (!isset($param_decode['user_id']) || $param_decode['user_id'] == null) {
            return false;
        }
        //给 user_id 赋值
        $this->user_id = $param_decode['user_id'];
        return true;
    }

    /**
     * @param $user_id
     * @return string
     */
    protected function jwt($user_id)
    {
        $key = 'wdfs32424XCVEs32CVX465484';
        $data = [
            "iss" => "kangye",
            "aud" => "boxinbaba",
            'user_id' => $user_id,
        ];
        return JWT::encode($data, $key);
    }

}

