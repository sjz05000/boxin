<?php

namespace app\common\model;

use think\Model;



// 联盟表
class Union extends Base
{
    /**
     * 图片加域名
     */
    // 联盟logo
    public function getLogoAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }
    // 联盟卡二维码
    public function getUnionCardLinkAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }
    // 联盟卡 logo 
    public function getUnionCardLogoAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }


    /**
     * 联盟分类
     */
    public function getUnionTypeAttr($v)
    {
        $arr = [1=>'线上', 2=>'线下', 3=>'综合'];
        return $arr[$v];
    }

    /**
     * 联盟类别
     */
    public function getUIdAttr($v)
    {
        return (new UnionClass())->getVal(['id'=>$v], 'title')['data'];
    }
}
