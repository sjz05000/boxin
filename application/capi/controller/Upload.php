<?php

namespace app\capi\controller;

use think\Controller;
use app\common\controller\Base;
use app\common\model\Commodity;

// c 端 b 端 公用
class Upload extends Base
{
    /**
     * 七牛
     * 上传文件-获取token
     */
    public function qiniu_token()
    {
        $this->result(['token'=>qiniutoken()], 200, '获取成功');
    }

    /**
     * 七牛
     * 删除上传的文件
     */
    public function qiniu_file_del()
    {
        qiniu_del($this->param['path']);
        $this->result([], 200, '删除成功');
    }

    /**
     * 本地服务器
     * 上传
     */
    public function img_up()
    {
        $file = request()->file('file');

        switch(input('type')){
            case 1:
                $dir = 'home/img';
            break;
            case 2:
                $dir = 'home/execl';
            break;
            case 3:
                $dir = 'home/video';
            break;
            case 4:
                $dir = 'home/pdf';
            break;
        }

        if(!file_exists('uploads/'.$dir)){
            mkdir('uploads/'.$dir);
        }
            
        return img_up($file, $dir);
    }

    /**
     * 本地服务器
     * 删除
     */
    public function img_del()
    {
        img_del(input('path'));
    }
    
}
