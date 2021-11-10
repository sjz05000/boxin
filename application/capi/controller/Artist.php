<?php

namespace app\capi\controller;

use think\Controller;
use app\common\controller\Base;
use app\common\model\User;
use app\common\model\UserCollection; // 用户收藏
use app\common\model\Union;       // 联盟表
use app\common\model\UnionClass;
use app\common\model\UnionVote;
use app\common\model\UnionVoteLog;
use app\common\model\UnionBusiness;  // 联盟内商家
use app\common\model\UnionCommodity; // 联盟商品表
use app\common\model\Star; // 明星表
use app\common\model\StarBackup;  // 后援会表
use app\common\model\StarBackupMember;
use app\common\model\StarSort;
use app\common\model\StarProgram;
use app\common\model\StarEntourage;
use app\common\model\Advertisement;  // 广告位
use app\common\model\AdvertisementExamine;
use app\common\model\AdvertisementDefault; // 广告默认表
use app\common\model\MoneyLog;
use app\common\model\PlatformRules; // 各种平台规则
use app\common\model\Order;
use app\common\model\DivideAd;        // 广告费保存表
use app\common\model\Business;      // 商家表
use app\common\model\NoticeNews;
use app\common\model\BusinessCooperation;
use app\common\model\BrokerageAgency; // 经纪公司
use app\common\model\BrokerageAgencyMember;
use app\common\model\StarStatistics;
use app\common\model\Set;
use app\common\model\Divide;  // 广告分成表
// use app\common\model\;
// use app\common\model\;
// use app\common\model\;

// 首页 - 艺人贡献
class Artist extends Base
{
    /**
     * 4个排行榜
     */
    public function star_sort()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_sort');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $unionModel = new Union();
        // 1=>合作商家 2=>联盟卡销量 3=>粉丝量 4=>商品销量
        switch($this->param['type']){
            case 1:

                $where = ['type'=>1, 'status'=>1, 'is_display'=>1];
                $field = 'id, user_id, name, logo, business_number, union_sales';
                $order = 'business_number desc';
                $res = $unionModel->getList($this->param['page'], $this->param['limit'], $where, $field, $order);

            break;

            case 2:

                $where = ['type'=>1, 'status'=>1, 'is_display'=>1];
                $field = 'id, user_id, name, logo, business_number, union_card_sell';
                $order = 'union_card_sell desc';
                $res = $unionModel->getList($this->param['page'], $this->param['limit'], $where, $field, $order);

            break;

            case 3:

                // 被关闭的明星联盟创建者id
                $where = ['type'=>1, 'status'=>1, 'is_display'=>0];
                $is_hide = $unionModel->getCol($where, 'user_id');
                if($is_hide['code'] != 200)
                {
                    $this->result([], 400, $is_hide['msg']);
                }

                // 
                $where_s[] = ['id','not in', $is_hide['data']];
                $where_s[] = ['is_display', '=', '1'];
                $field = 'id, fans_number';
                $res = (new Star())->getList($this->param['page'], $this->param['limit'], $where_s, $field, 'fans_number desc');
                if($res['code'] != 200)
                {
                    $this->result([], 400, $res['msg']);
                }
                $user = new User();
                foreach($res['data'] as &$v)
                {
                    $info = $user->getInfo(['id'=>$v['id']], 'nickname, head')['data'];
                    $v['name'] = $info['nickname']; 
                    $v['logo'] = $info['head']; 
                    $v['user_id'] = $v['id'];   // 明星id
                    $a = $unionModel->getInfo(['user_id'=>$v['id']], 'id, union_card_sell');
                    if($a['code'] != 200){
                        // 写0,是该明星没有建立联盟
                        $v['id'] = 0;
                        $v['union_card_sell'] = 0;
                    }else{
                        $v['id'] = $a['data']['id'];
                        $v['union_card_sell'] = $a['data']['union_card_sell'];
                    }
                }
                
            break;

            case 4:

                $where = ['type'=>1, 'status'=>1, 'is_display'=>1];
                $field = 'id, user_id, name, logo, only, union_sales';
                $order = 'union_sales desc';
                $res = $unionModel->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
            break;
        }

        if($res['code'] != 200)
        {
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }
    
    /**
     * 搜索明星
     */
    public function star_search()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_search');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        $where = [];
        $where[] = ['is_star', '=', 1];
        $where[] = ['nickname', 'like', '%'.$this->param['search'].'%'];
        $field = 'id, nickname, head';
        $res = (new User())->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $this->result($res['data'], 400, '获取数据成功');
    }

    /**
     * 搜索下的列表
     */
    public function star_list()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        $where[] = ['is_display', '=', 1];
        $field = 'user_id';
        $order = 'fans_number desc';
        $res = (new Star())->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();
        foreach($res['data'] as &$v)
        {
            $info = $um->getInfo(['id'=>$v['user_id']], 'id, nickname, head');
            $v['id'] = $info['data']['id'];
            $v['nickname'] = $info['data']['nickname'];
            $v['head'] = $info['data']['head'];
            unset($v['user_id']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 艺人详情界面
     */
    public function star_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $info = (new user())->getInfo(['id'=>$this->param['id']], 'id, nickname, head');
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }

        $star_info = (new Star)->getInfo(['user_id'=>$this->param['id']], 'fans_number, backup_number, star_number, is_auth, is_company');
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }

        // 检测显示广告位否  1=> 显示 0=> 不
        $advert = 0; // 默认不显示
        $where = [];
        $where[] = ['user_id', '=', $this->user_id];
        $where[] = ['star_id', '=', $this->param['id']];
        $where[] = ['status', '=', 1];
        $where[] = ['is_display', '=', 1];
        // 是否为该明星建立后援会
        $res_b = (new StarBackup())->getInfo($where, 'id');
        if($res_b['code'] == 200){
            // 该后援会是否月结第一的id
            $id = (new StarSort())->getInfo(['star_id'=>$this->param['id']], 'sb_id');
            if($id['code'] != 200){
                $this->result([], 400, $id['msg']);
            }
            if($id['data']['sb_id'] == $res_b['data']['id']){
                $advert = 1;
            }
        }
        
        // 是否关注 1=> 关注 0=> 没
        $where = [];
        $where[] = ['user_id', '=', $this->user_id];
        $where[] = ['obj_type', '=', 2];
        $where[] = ['obj_id', '=', $this->param['id']];
        $res_c = (new UserCollection())->getInfo($where);
        if($res_c['code'] == 200){
            $is_collect = 1;
        }else{
            $is_collect = 0;
        }

        // 背景图
        $background_img = (new AdvertisementDefault())->getInfo(['id'=>8], 'img');
        
        $data = [
            'id' => $info['data']['id'],
            'name' => $info['data']['nickname'],
            'head' => $info['data']['head'],
            'fans_number' => $star_info['data']['fans_number'],
            'backup_number' => $star_info['data']['backup_number'],
            'star_number' => $star_info['data']['star_number'],
            'background_img' => $background_img['data']['img'],
            'is_auth' => $star_info['data']['is_auth'], // 0=>未 1=>已认证
            'is_company' => $star_info['data']['is_company'], // 0=>未 1=>已认证
            'is_collect' => $is_collect, // 收藏
            'is_advert' => $advert,  // 是否显示广告位
        ];

        // 添加足迹
        add_footprint(3, $this->param['id'], $this->user_id, date('Y-m-d'));

        $this->result($data, 200, '获取数据成功');
    }

    /**
     * 艺人行程/作品
     */
    public function star_program()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_program');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        $where[] = ['user_id', '=', $this->param['id']];
        $where[] = ['type', '=', $this->param['type']];
        $where[] = ['status', '=', 1];
        $field = 'id, banner, title, create_time';
        $order = 'id desc';
        $res = (new StarProgram())->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        foreach($res['data'] as $v)
        {
            $v['create'] = date('Y.m.d', strtotime($v['create_time']));
            unset($v['create_time']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 艺人行程/作品详情
     */
    public function star_program_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_program_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $field = 'banner, title, content, create_time';
        $res = (new StarProgram())->getInfo(['id'=>$this->param['id']], $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        
        $res['data']['create'] = date('Y/m/d H:i', strtotime($res['data']['create_time']));
        unset($res['data']['create_time']);

        $this->result($res['data'], 200, '获取数据成功');

    }

    /**
     * 艺人介绍+随从
     */
    public function star_entourage()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_entourage');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 随从
        $where = [];
        $where[] = ['user_id', '=', $this->param['id']];
        $field = 'job, name, head';
        $res = (new StarEntourage())->getList(0, 0, $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 艺人信息
        $info = (new User())->getInfo(['id'=>$this->param['id']], 'nickname, head, only');
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }

        // 艺人公告
        $sm = new Star();
        $notice = $sm->getInfo(['user_id'=>$this->param['id']], 'notice');
        if($notice['code'] != 200){
            $this->result([], 400, $notice['msg']);
        }

        $data = [
            'info' => $info['data'],
            'ent'  => $res['data'],
            'notice' => $notice['data']['notice'],
        ];

        $this->result($data, 200, '获取数据成功');
    }

    /**
     * 艺人详情介绍
     */
    public function star_introduce_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_introduce_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new Star())->getInfo(['user_id'=>$this->param['id']], 'title, content');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 轮播图  公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function banner()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.banner');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 获取当前的期数
        $t = date("j");
        if($t >= 1 && $t < 8){
            $stage = 1;
        }else if($t >= 8 && $t < 16){
            $stage = 2;
        }else if($t >= 16 && $t < 24){
            $stage = 3;
        }else{
            $stage = 4;
        }
                      

        // 获取当前艺人/后援会/经纪公司等等发布的广告位id
        $where = [];
        //obj_type  1=>联盟首页广告位 2=>艺人排行广告位  3=>经纪公司排行广告位  4=>后援会详情广告位  5=>艺人详情广告位  6=>经纪详情广告位  7=>抢单  
        $where[] = ['obj_type', '=', $this->param['type']];

        // 根据obj_type内容来的,type为1,2,3,7时,obj_id不需要
        if(in_array($this->param['type'], [4, 5, 6])){
            $where[] = ['obj_id', '=', $this->param['id']];
        }
        $where[] = ['status', '=', 1];
        $where[] = ['stage', '=', $stage];
        $field = 'id, position';
        $order = 'position';
        $res = (new Advertisement())->getList(0, 0, $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 获取购买者图片信息
        $arr = [];
        $adm = new AdvertisementExamine();
        $array = ['第一广告位'=>1, '第二广告位'=>2, '第三广告位'=>3];
        foreach($res['data'] as $v)
        {
            $res_img = $adm->getInfo(['a_id'=>$v['id'], 'status'=>1, 'is_admin'=>1], 'img, jump_link');
            if($res_img['code'] != 200){
                continue;
            }

            $arr[ $array[$v['position']] ] = $res_img['data'];
        }

        // 获取轮播默认图片
        $img_default = (new AdvertisementDefault())->getInfo(['id'=>5], 'img, jump_link');
        if($img_default['code'] != 200){
            $this->result([], 400, $img_default['msg']);
        }

        // 检查3个广告是否齐全
        for($i=1; $i<=3; $i++)
        {
            if(!isset($arr[$i])){
                $arr[$i] = $img_default['data'];
            }
        }

        $this->result($arr, 200, '获取数据成功');
    }

    /**
     * 发布广告规则 公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function banner_rules()
    {
        $res = (new PlatformRules())->getList(0, 0, [ ['id','in', '3,4'] ], 'title, content');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 发布广告 公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function add_banner()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.add_banner');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $adm = new Advertisement();

        // 4=>后援会详情广告位        后援会创建者发布
        // 5=>艺人详情广告位          月结第一后援会会长发布
        // 6=>经纪详情广告位          经纪公司创建者发布

        // 发布者 5 跟别的不一样
        if($this->param['type'] == 5){
            // 为5时, 发布者为当前明星月结第一的后援会id
            $res_id = (new StarSort())->getInfo(['star_id'=>$this->param['id']], 'sb_id');
            if($res_id['code'] != 200){
                $this->result([], 400, $res_id['msg']);
            }
            $id = $res_id['data']['sb_id'];
        }else{
            // 4=>获取后援会会长id, 6=>获取经纪公司的创建者id
            $id = $this->user_id;
        }

        $data = [
            'user_id'  => $id,
            'obj_type' => $this->param['type'],
            'obj_id'   => $this->param['id'],
            'price'    => $this->param['price'],
            'position' => $this->param['position'],
            'stage'    => $this->param['stage'],
        ];

        // 设置每期广告的开始结束时间
        switch($this->param['stage']){
            case 1:
                $data['start_time'] = date('Y/m/1 00:00:00', time());
                $data['end_time']   = date('Y/m/7 23:59:59', time());
            break;
            case 2:
                $data['start_time'] = date('Y/m/8 00:00:00', time());
                $data['end_time']   = date('Y/m/15 23:59:59', time());
            break;
            case 3:
                $data['start_time'] = date('Y/m/16 00:00:00', time());
                $data['end_time']   = date('Y/m/23 23:59:59', time());
            break;
            case 4:
                $data['start_time'] = date('Y/m/24 00:00:00', time());
                $data['end_time']   = date('Y/m/'.date("t").' 23:59:59', time());
            break;
        }


        // 检测当月是否发过该广告位
        $month_start = strtotime(date("Y-m-01"));
        $month_end = strtotime("+1 month -1 seconds", $month_start);

        $where = [];
        $where[] = ['obj_type', '=', $this->param['type']];
        $where[] = ['stage', '=', $this->param['stage']];
        $where[] = ['obj_id', '=', $this->param['id']];
        $where[] = ['position', '=', $this->param['position']];
        $where[] = ['user_id', '=', $id];
        $where[] = ['create_time','between time', [$month_start, $month_end]];
        $is_res = $adm->getInfo($where);
        if($is_res['code'] == 200){
            $this->result([], 400, '该位置的广告已发布');
        }

        // 订单号
        $data['order_no'] = getOrderNo();
        $res = $adm->add($data);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 生成订单 
        $info = [
            'order_no' =>$data['order_no'],
            'type' => 1,
            'obj_type' => 2,
            'obj_id' => $res['data'],
            'money' => $data['price'],
            'pay_type' => 1,
            'order_type' => 3,
            'order_status' =>1,
        ];
        $res_o = (new Order())->add($info);
        

        $this->result([], 200, '发布成功');
    }

    /**
     * 广告位列表 公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function banner_list()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.banner_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 月初,月末时间戳
        $month_start = strtotime(date("Y-m-01"));
        $month_end = strtotime("+1 month -1 seconds", $month_start);

        $where = [];
        // status 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
        $where[] = ['obj_type', '=', $this->param['status']];
        $where[] = ['obj_id', '=', $this->param['id']];
        $where[] = ['create_time', '>', $month_start];
        $where[] = ['create_time', '<', $month_end];
        $field = 'id, price, stage, position, status, start_time, end_time';
        $order = 'stage, position';

        // 获取当前的期数
        $t = date("j");
        if($t >= 1 && $t < 8){
            $stage = 1;
        }else if($t >= 8 && $t < 16){
            $stage = 2;
        }else if($t >= 16 && $t < 24){
            $stage = 3;
        }else{
            $stage = 4;
        }

        // 1=>展示中 2=>已到期 3=>待投放 4=>发布中
        switch($this->param['type']){

            case 1:
                $where[] = ['stage', '=', $stage];
                $where[] = ['status', '=', 1];
            break;

            case 2:
                $where[] = ['status', '=', 2];
            break;

            case 3:
                $where[] = ['stage', '>', $stage];
                $where[] = ['status', '=', 1];
            break;

            case 4:
                $where[] = ['status', '=', 0];
            break;
        }

        $res = (new Advertisement())->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();          // 用户
        $aem = new AdvertisementExamine(); // 审核广告表
        $adm = new AdvertisementDefault(); // 默认广告图


        if($this->param['status'] == 4 || $this->param['status'] == 5 ){
            $ssm = new StarSort();     // 后援会月结记录表
            $sbm = new StarBackup();   // 后援会表
        }else if($this->param['status'] == 6){
            $bam = new BrokerageAgency();      // 经纪公司
        }
        

        // 状态 为1时,有展示中,待投放两种状态
        $stage_arr = [1=>'第一期广告', 2=>'第二期广告', 3=>'第三期广告', 4=>'第四期广告'];
        $status = [0=>'发布中', 1=>'展示中', 2=>'已过期'];

        foreach($res['data'] as $v)
        {
            // status 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
            if($this->param['status'] == 4){

                // 后援会信息
                $res_a = $sbm->getInfo(['id'=>$this->param['id']], 'star_id, name, logo')['data'];
                // 所属明星
                $v['star_name'] = $um->getVal(['id'=>$res_a['star_id']], 'nickname')['data'];

            }else if($this->param['status'] == 5){

                // 获取后援会月结第一的id,从而找出后援信息
                $id = $ssm->getInfo(['star_id'=>$this->param['id']], 'sb_id')['data']['sb_id'];
                $res_a = $sbm->getInfo(['id'=>$id], 'name, logo')['data'];
                // 所属明星
                $v['star_name'] = $um->getVal(['id'=>$this->param['id']], 'nickname')['data'];

            }else if($this->param['status'] == 6){

                // 经纪公司信息
                $res_a = $bam->getInfo(['id'=>$this->param['id']], 'name, logo')['data'];
            }
            
            $v['backup_name'] = $res_a['name'];
            $v['backup_logo'] = $res_a['logo'];


            if($v['status'] == 0){
                // 默认招商图
                $v['img'] = $adm->getInfo(['id'=>9],'img')['data']['img'];
            }else{
                // 展示的广告图
                $res_img = $aem->getInfo(['a_id'=>$v['id'], 'status'=>1], 'img');
                if($res_img['code'] != 200){
                    // 没人买的过期广告,给默认招商图
                    $v['img'] = $adm->getInfo(['id'=>9],'img')['data']['img'];
                }else{
                    $v['img'] = $res_img['data']['img'];
                }
            }

            // 用来区分展示中,待投放
            if($v['status'] ==1){
                $v['status'] = $v['stage'] == $stage_arr[$stage] ? '展示中' : '待投放'; 
            }else{
                $v['status'] = $status[$v['status']];
            }
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 广告位详情 公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function banner_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.banner_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 广告详情
        $adm = new Advertisement();
        $where = [];
        $where[] = ['id', '=', $this->param['id']];
        $field = 'id, obj_type, obj_id, price, stage, position, status, order_no, start_time, end_time, user_id';
        $res = $adm->getInfo($where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();

        if($res['data']['obj_type'] == 4 || $res['data']['obj_type'] == 5){
            $sbm = new StarBackup();
        }

        // status 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
        switch($res['data']['obj_type']){

            case 4:
                 // 获取后援会的id,从而找出后援信息
                $res_a = $sbm->getInfo(['id'=>$res['data']['obj_id']], 'name, logo')['data'];
            break;

            case 5:
                // 获取后援会的id,从而找出后援信息
                $res_a = $sbm->getInfo(['id'=>$res['data']['user_id']], 'name, logo')['data'];
            break;

            case 6:
                 // 获取经纪公司的id, 找出信息
                $res_a = (new BrokerageAgency())->getInfo(['id'=>$res['data']['obj_id']], 'name, logo')['data'];
            break;
        }
        
        $res['data']['backup_name'] = $res_a['name'];
        $res['data']['backup_logo'] = $res_a['logo'];
        // 所属明星
        $res['data']['star_name'] = $um->getVal(['id'=>$res['data']['obj_id']], 'nickname')['data'];


        // 购买者的信息
        $res_i = (new AdvertisementExamine())->getInfo(['a_id'=>$this->param['id'], 'status'=>1], 'img, user_id, create_time');
        if($res_i['code'] == 200){
            $res['data']['img'] = $res_i['data']['img'];
            $res_a = (new Business())->getInfo(['id'=>$res_i['data']['user_id']], 'only');
            // 商家信息
            $res['data']['purchase_only'] = $res_a['data']['only'];
            $res['data']['purchase_time'] = $res_i['data']['create_time'];
        }else{
            // 默认图
            $res['data']['img'] = (new AdvertisementDefault())->getInfo(['id'=>9],'img')['data']['img'];
            // 商家信息
            $res['data']['purchase_only'] = '';
            $res['data']['purchase_time'] = '';
        }

        // 获取当前的期数
        $t = date("j");
        if($t >= 1 && $t < 8){
            $stage = '第一期广告';
        }else if($t >= 8 && $t < 16){
            $stage = '第二期广告';
        }else if($t >= 16 && $t < 24){
            $stage = '第三期广告';
        }else{
            $stage = '第四期广告';
        }
        switch($res['data']['status']){

            case 0:
                $res['data']['status'] = '发布中';
            break;

            case 1:
                if($res['data']['stage'] != $stage){
                    $res['data']['status'] = '待投放';
                }else if($res['data']['stage'] == $stage){
                    $res['data']['status'] = '展示中';
                }
            break;

            case 2;
                $res['data']['status'] = '已到期';
            break;
        }

        unset($res['data']['obj_id']);
        unset($res['data']['obj_type']);
        unset($res['data']['user_id']);

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 广告位筛选 公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function banner_screen()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.banner_screen');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        $where[] = ['a.obj_type', '=', $this->param['type']];
        $where[] = ['a.obj_id', '=', $this->param['id']];
        $where[] = ['a.price', '>=', $this->param['price']];  // 价格搜索
        $where[] = ['a.position', 'in', $this->param['position']]; // 位置搜索
        $where[] = ['a.create_time', '>=', $this->param['start_time']];  // 时间搜索

        // type 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
        switch($this->param['type']){

            case 4:

                $where[] = ['s.fans_number', '>=', $this->param['fans_number']]; // 后援会粉丝量
                $field = 'a.id, s.name, s.logo, a.status, a.stage, a.position, u.nickname, a.start_time, a.end_time, a.price';

                $res = db('Advertisement') // 广告位表
                ->alias('a')
                ->join('StarBackup s','a.obj_id = s.id')  // 后援会表
                ->join('User u','u.id = s.star_id')       // 获取所属明星名称
                ->where($where)
                ->field($field)
                ->page($this->param['page'], $this->param['limit'])
                ->order('a.stage , a.position')
                ->select();

                $title = '后援会详情广告位';
            break;

            case 5:
                
                $where[] = ['s.fans_number', '>=', $this->param['fans_number']]; // 后援会粉丝量
                $field = 'a.id, s.name, s.logo, a.status, a.stage, a.position, u.nickname, a.start_time, a.end_time, a.price';

                $res = db('Advertisement') // 广告位表
                ->alias('a')
                ->join('StarBackup s','a.user_id = s.id')  // 后援会表
                ->join('User u','a.obj_id = u.id')       // 获取所属明星名称
                ->where($where)
                ->field($field)
                ->page($this->param['page'], $this->param['limit'])
                ->order('a.stage , a.position')
                ->select();

                $title = '艺人详情广告位';
            break;

            case 6:
                // nickname 是凑数的,好让前端遍历
                $field = 'a.id, b.name, b.logo, a.status, a.stage, a.position, a.start_time, a.end_time, a.price, a.id as nickname';

                $res = db('Advertisement') // 广告位表
                ->alias('a')
                ->join('BrokerageAgency b','a.obj_id = b.id')    // 经纪公司表
                ->where($where)
                ->field($field)
                ->page($this->param['page'], $this->param['limit'])
                ->order('a.stage , a.position')
                ->select();

                $title = '经纪详情广告位';

            break;
        }

        // 广告位置
        $position = [1=>'第一广告位', 2=>'第二广告位', 3=>'第三广告位'];
        // 第几期广告
        $stage = [1=>'第一期广告', 2=>'第二期广告', 3=>'第三期广告', 4=>'第四期广告'];

        // 状态 为1时,有展示中,待投放两种状态
        $status = [0=>'发布中', 1=>'展示中', 2=>'已过期'];
        // 获取当前的期数,用来区分展示中,待投放
        $t = date("j");
        if($t >= 1 && $t < 8){
            $st = 1;
        }else if($t >= 8 && $t < 16){
            $st = 2;
        }else if($t >= 16 && $t < 24){
            $st = 3;
        }else{
            $st = 4;
        }

        $aem = new AdvertisementExamine(); // 申请广告位表
        $adm = new AdvertisementDefault(); // 默认图表
        foreach($res as &$v){
            
            // 获取放置在广告位的图
            $ad_img = $aem->getInfo(['a_id'=>$v['id'], 'status'=>1], 'id, img');
            if($ad_img['code'] != 200){
                $v['img'] = $adm->getInfo(['id'=>9],'img')['data']['img'];
            }else{
                $v['img'] = $ad_img['data']['img'];
            }

            // 用来区分展示中,待投放
            if($v['status'] ==1){
                $v['status'] = $v['stage'] == $st ? '展示中' : '待投放'; 
            }else{
                $v['status'] = $status[$v['status']];
            }
            $v['stage'] = $stage[$v['stage']];
            $v['position'] = $position[$v['position']];

            if(strpos($v['logo'],'uploads') === false){
                $v['logo'] = config('app.qiniu.cdnUrl').$v['logo'];
            }else{
                $v['logo'] = config('app.url').$v['logo'];
            }

            $v['title'] = $title;
        }

        $this->result($res, 200, '获取数据成功');

    }
    
    /**
     * + 按钮 
     * 广告位选择  公用
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位 
     */
    public function banner_choice()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.banner_choice');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 发布的广告位
        $month_start = strtotime(date("Y-m-01"));
        $month_end = strtotime("+1 month -1 seconds", $month_start);
        $where = [];
        $where[] = ['obj_type', '=', $this->param['type']];
        $where[] = ['obj_id', '=', $this->param['id']];
        $where[] = ['create_time', '>', $month_start];
        $where[] = ['create_time', '<', $month_end];
        $field = 'id, order_no, stage, position, price, status, obj_id, user_id';
        $order = 'stage, position';
        $res = (new Advertisement())->getList(0, 0, $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();

        if($this->param['type'] == 4 || $this->param['type'] == 5){
            $sbm = new StarBackup();
        }else{
            $bam = new BrokerageAgency();
        }

        $aem = new AdvertisementExamine();
        $adm = new AdvertisementDefault();
        foreach($res['data'] as $v)
        {
            // type 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
            switch($this->param['type']){
                case 4:
                    $res_a = $sbm->getInfo(['id'=>$v['obj_id']], 'name, logo, star_id')['data'];
                    // 所属明星
                    $v['star_name'] = $um->getVal(['id'=>$res_a['star_id']], 'nickname')['data'];
                break;
                case 5:
                    $res_a = $sbm->getInfo(['id'=>$v['user_id']], 'name, logo')['data'];
                    // 所属明星
                    $v['star_name'] = $um->getVal(['id'=>$this->param['id']], 'nickname')['data'];
                break;
                case 6:
                    $res_a = $bam->getInfo(['id'=>$v['obj_id']], 'name, logo')['data'];
                    $v['star_name'] = '';
                break;
            }
            $v['backup_name'] = $res_a['name'];
            $v['backup_logo'] = $res_a['logo'];


            if($v['status'] == 0){

                // 默认招商广告图
                $v['img'] = $adm->getInfo(['id'=>9],'img')['data']['img'];

                // 申请的列表
                $res_m = $aem->getList(0, 0, ['a_id'=>$v['id']], 'id, user_id, offer');

                foreach($res_m['data'] as $vv)
                {   
                    $res_u = $um->getInfo(['id'=>$vv['user_id']], 'nickname, head, only');
                    $vv['nickname'] = $res_u['data']['nickname'];
                    $vv['head'] = $res_u['data']['head'];
                    $vv['only'] = $res_u['data']['only'];

                    unset($vv['user_id']);
                }
                
                $v['list'] = $res_m['data'];
            }else{
                // 广告位已卖出,展示卖出的广告图片,还有种可能没人买过期了.
                $is_img = $aem->getInfo(['a_id'=>$v['id'], 'status'=>1], 'img');
                if($is_img['code'] != 200){
                    // 默认招商广告图
                    $v['img'] = $adm->getInfo(['id'=>9],'img')['data']['img'];
                }else{
                    $v['img'] = $aem->getInfo(['a_id'=>$v['id'], 'status'=>1], 'img')['data']['img'];
                }
            }

            unset($v['user_id']);
            unset($v['obj_id']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * + 按钮 公用
     * 广告位选择
     * 合作
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function cooperation()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.cooperation');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        $um = new User();        // 用户表
        // 修改广告位已购买
        $am = new Advertisement();
        $am->edit(['id'=>$this->param['id'], 'status'=>1]);

        // 获取该广告信息
        $res_a = $am->getInfo(['id'=>$this->param['id']], 'obj_type, obj_id, user_id, order_no');
        if($res_a['code'] != 200){
            $this->result([], 400, $res_a['msg']);
        }

        // type 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
        // 获取广告位所属名字(有明星,后援后,经纪)
        $dam = new DivideAd();   // 广告费保存表
        $dm = new Divide();      // 广告费分成表
        switch($res_a['data']['obj_type']){

            case 4:
                // 后援会表
                $sbm = new StarBackup();

                // 后援会名称,得出通知名称
                $res_b = $sbm->getInfo(['id'=>$res_a['data']['obj_id']], 'name, star_id')['data'];
                $notice_name = '【'.$res_b['name'].'】后援会详情页广告位';
                // 得出保存广告费的id, 后援会广告分成以,后援会id为主记录
                $data = ['month'=>date('Y/m'), 'type'=>4, 'b_id'=>$res_a['data']['obj_id'], 'star_id'=>$res_b['star_id']];
                $res_id = $dam->getInfo($data, 'id');
                if($res_id['code'] != 200){
                    $id = $dam->add($data)['data'];
                }else{
                    $id = $res_id['data']['id'];
                }

                // 后援会分成百分比
                $divide = $dm->getVal(['id'=>1], 'backup')['data'] * 0.01;
            break;

            case 5:
                // 后援会表
                $sbm = new StarBackup();

                // 明星的名称,得出通知名称
                $notice_name = '【'.$um->getVal(['id'=>$res_a['data']['obj_id']], 'nickname')['data'].'】明星详情页广告位'; 

                // 得出保存广告费的id, 明星广告分成以,明星id,月结后援会第一id.两个为主记录
                $data = ['month'=>date('Y/m'), 'type'=>5, 'star_id'=>$res_a['data']['obj_id'], 'b_id'=>$res_a['data']['user_id']];
                $res_id = $dam->getInfo($data, 'id');
                if($res_id['code'] != 200){
                    $id = $dam->add($data)['data'];
                }else{
                    $id = $res_id['data']['id'];
                }

                // 后援会分成百分比
                $divide = $dm->getVal(['id'=>2], 'backup')['data'] * 0.01;
            break;

            case 6:
                // 经纪公司表
                $bam = new BrokerageAgency(); 

                // 经纪公司名称,得出通知名称
                $notice_name = '【'.$bam->getVal(['id'=>$res_a['data']['obj_id']], 'name')['data'].'】经纪公司详情页广告位'; 

                // 得出保存广告费的id, 经纪公司广告分成以, 经纪公司id为主记录 
                $data = ['month'=>date('Y/m'), 'type'=>6, 'ba_id'=>$res_a['data']['obj_id']];
                $res_id = $dam->getInfo($data, 'id');
                if($res_id['code'] != 200){
                    $id = $dam->add($data)['data'];
                }else{
                    $id = $res_id['data']['id'];
                }
            break;
        }

        // 获取广告订单信息
        $om = new Order();
        $order_info = $om->getInfo(['order_no'=>$res_a['data']['order_no']], 'id');
        if($order_info['code'] != 200){
            $this->result([], 400, $order_info['msg']);
        }

        // 查出该广告下,所有待审核申请
        $adm = new AdvertisementExamine();
        $res = $adm->getList(0, 0, ['a_id'=>$this->param['id'], 'status'=>0], 'id, user_id, offer');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $mlm = new MoneyLog();   // 交易记录表
        $nnm = new NoticeNews(); // 重要通知表
        foreach($res['data'] as $v)
        {
            if($v['id'] == $this->param['a_id']){
                // 更改申请信息状态
                $adm->edit(['id'=>$v['id'], 'status'=>1]);

                // 广告订单确认
                $om->edit(['id'=>$order_info['data']['id'], 'pay_status'=>1, 'user_id'=>$v['user_id'], 'money'=>$v['offer']]);

                // 修改申请者广告购买记录
                $mlm->editWhere(['describe'=>'购买广告位(同意)'], ['user_id'=>$v['user_id'], 'order_id'=>$order_info['data']['id'], 'type'=>2, 'money'=>$v['offer'], 'money_type'=>1, 'order_type'=>8, 'operation'=>0]);

                // 申请者冻结金减少
                $um->setDecField(['id'=>$v['user_id']],'frozen_money', $v['offer']);

                // 获取现在用户的,冻结金的余额
                $frozen_money = $um->getVal(['id'=>$v['user_id']], 'frozen_money')['data'];
                
                // 加申请者冻结金记录减少
                $mlm->add(['user_id'=>$v['user_id'], 'order_id'=>$order_info['data']['id'], 'type'=>2, 'money'=>$v['offer'], 'balance'=>$frozen_money, 'money_type'=>2, 'order_type'=>8,'operation'=>0, 'describe'=>'支付广告费']);

                // 给该商家发送通知(该通知归属,重要通知)
                $nnm->add(['type'=>2, 'class'=>3, 'to_user_id'=>$v['user_id'], 'content'=>'<p>尊敬的用户您申请购买的'.$notice_name.'，发布者已同意，广告费将从冻结金减去。</p>']);

            //-----------------------------------------------------------------//                
                if($res_a['data']['obj_type'] == 4 || $res_a['data']['obj_type'] == 5){
                    // 分给后援会的分成,为了分成后援会排行榜
                    $sbm->setIncField(['id'=>$res_a['data']['user_id']], 'divide', $v['offer'] * $divide );
                }
                
                // 增加广告费
                $dam->setIncField(['id'=>$id], 'money', $v['offer']);

            //-------------------------------------------------------------------//
                
            }else{
                // 其他申请者请求默认拒绝
                $a = db('AdvertisementExamine')->where(['id'=>$v['id']])->update(['status'=>2]);
                // 修改申请者广告购买记录
                $mlm->editWhere(['describe'=>'购买广告位(拒绝)'], ['user_id'=>$v['user_id'], 'order_id'=>$order_info['data']['id'], 'type'=>2, 'money'=>$v['offer'], 'money_type'=>1, 'order_type'=>8, 'operation'=>0]);

                // 用户冻结金退还(减少)
                $um->setDecField(['id'=>$v['user_id']], 'frozen_money', $v['offer']);
                
                // 获取现在用户的,冻结金的余额
                $frozen_money = $um->getVal(['id'=>$v['user_id']], 'frozen_money')['data'];

                // 冻结金退还记录
                db('MoneyLog')->insert(['user_id'=>$v['user_id'], 'order_id'=>$order_info['data']['id'],'type'=>2, 'money'=>$v['offer'], 'balance'=>$frozen_money, 'money_type'=>2, 'order_type'=>8, 'operation'=>0, 'describe'=>'退还广告费', 'create_time'=>time()]);
                
                // 用户余额增加
                $um->setIncField(['id'=>$v['user_id']], 'money', $v['offer']);

                // 获取现在用户的余额
                $balance = $um->getVal(['id'=>$v['user_id']], 'money')['data'];

                // 余额增加记录
                $a = db('MoneyLog')->insert(['user_id'=>$v['user_id'], 'order_id'=>$order_info['data']['id'], 'type'=>2, 'money'=>$v['offer'], 'balance'=>$balance, 'money_type'=>1, 'order_type'=>8, 'operation'=>1, 'describe'=>'退还广告费', 'create_time'=>time()]);

                // 给该商家发送通知(该通知归属,重要通知)  
                db('NoticeNews')->insert(['type'=>2, 'class'=>3, 'to_user_id'=>$v['user_id'], 'content'=>'<p>尊敬的用户您申请购买的'.$notice_name.'，被发布者拒绝，支付的广告费原路退还至余额。</p>', 'create_time'=>time()]);
            }
        }

        $this->result([], 200, '操作成功');
    }

    /**
     * + 按钮  公用
     * 广告位选择
     * 不合作
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function no_cooperation()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.cooperation');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $am = new Advertisement();
        // 获取广告订单id
        $order_no = $am
        ->alias('a')
        ->join('Order o','o.order_no = a.order_no')
        ->where(['a.id'=>$this->param['id']])
        ->field('o.id, a.obj_type, a.obj_id, a.user_id')
        ->find();

        // 修改申请信息状态
        $adm = new AdvertisementExamine();
        $adm->edit(['a_id'=>$this->param['id'], 'id'=>$this->param['a_id'], 'status'=>2]);

        // 获取申请信息
        $info = $adm->getInfo(['id'=>$this->param['a_id']], 'user_id, offer');
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }

        $um = new User();
        $mlm = new MoneyLog();

        // 修改申请者广告购买记录 ???
        $a =$mlm->editWhere(['describe'=>'购买广告位(拒绝)'], ['user_id'=>$info['data']['user_id'], 'order_id'=>$order_no['id'], 'type'=>2, 'money'=>$info['data']['offer'], 'money_type'=>1, 'order_type'=>8, 'operation'=>0]);
        if($a['code'] != 200){
            $this->result([], 400, $a['msg']);
        }

        // 冻结金退还(减少)
        $um->setDecField(['id'=>$info['data']['user_id']], 'frozen_money', $info['data']['offer']);
        
        // 当前用户冻结金余额
        $frozen_money = $um->getVal(['id'=>$info['data']['user_id']], 'frozen_money')['data'];

        // 冻结金退还记录
        $a =$mlm->add(['user_id'=>$info['data']['user_id'], 'order_id'=>$order_no['id'], 'type'=>2, 'money'=>$info['data']['offer'], 'balance'=>$frozen_money, 'money_type'=>2, 'order_type'=>8, 'operation'=>0, 'describe'=>'退还广告费']);
        if($a['code'] != 200){
            $this->result([], 400, $a['msg']);
        }

        // 余额增加
        $um->setIncField(['id'=>$info['data']['user_id']], 'money', $info['data']['offer']);

        // 当前用户余额
        $money = $um->getVal(['id'=>$info['data']['user_id']], 'money')['data'];

        // 余额增加记录
        db('MoneyLog')->insert(['user_id'=>$info['data']['user_id'], 'order_id'=>$order_no['id'], 'type'=>2, 'money'=>$info['data']['offer'], 'balance'=>$money, 'money_type'=>1, 'order_type'=>8, 'operation'=>1, 'describe'=>'退还广告费', 'create_time'=>time()]);
 
        // 给该商家发送通知(该通知归属,重要通知)
        switch($order_no['obj_type']){
            case 4:
                $sbm = new StarBackup();
                $notice_name = '【'.$sbm->getVal(['id'=>$order_no['obj_id']], 'name')['data'].'】后援会详情页广告位';
            break;
            case 5:
                $notice_name = '【'.$um->getVal(['id'=>$order_no['obj_id']], 'nickname')['data'].'】明星详情页广告位';
            break;
            case 6:
                $bam = new BrokerageAgency(); 
                $notice_name = '【'.$bam->getVal(['id'=>$order_no['obj_id']], 'name')['data'].'】经纪公司详情页广告位';
            break;
        }
        $nnm = new NoticeNews();
        $a = $nnm->add(['type'=>2, 'class'=>3, 'to_user_id'=>$info['data']['user_id'], 'content'=>'<p>尊敬的用户您申请购买的'.$notice_name.'，被发布者拒绝，支付的广告费原路退还至余额。</p>']);
        if($a['code'] != 200){
            $this->result([], 400, $a['msg']);
        }

        $this->result([], 200, '操作成功');
    }

    /**
     * + 按钮  公用
     * 广告位选择记录
     * 
     * 艺人详情页广告位
     * 后援会详情页广告位
     * 经纪公司详情页广告位
     */
    public function banner_choice_log()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.banner_choice_log');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        // type 广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
        $where[] = ['a.obj_type', '=', $this->param['status']];
        $where[] = ['a.obj_id', '=', $this->param['id']];
        // 1=>已合作 2=>未合作
        if($this->param['type'] != 0){
            $where[] = ['ae.status', '=', $this->param['type']];
        }
        // 时间区间查询
        $where[] = ['ae.create_time', 'between time', [$this->param['start_time'], $this->param['end_time']]];
        
        $field = 'a.order_no, ae.img, a.stage, a.position, a.price, a.start_time, a.end_time, ae.status, ae.offer, ae.create_time, b.name, b.logo, b.only, a.obj_type, a.obj_id';

        $res = db('AdvertisementExamine') // 广告位审核表
        ->alias('ae')
        ->join('Advertisement a','a.id = ae.a_id') // 广告位表
        ->join('Business b', 'b.id = ae.user_id')  // 获取商家信息
        ->where($where)
        ->field($field)
        ->page($this->param['page'], $this->param['limit'])
        ->order('a.stage , a.position')
        ->select();


        // 广告位置
        $position = [1=>'第一广告位', 2=>'第二广告位', 3=>'第三广告位'];
        // 第几期广告
        $stage = [1=>'第一期广告', 2=>'第二期广告', 3=>'第三期广告', 4=>'第四期广告'];
        // 状态
        $status = [0=>'待审核', 1=>'已合作', 2=>'未合作'];

        $um = new User();
        $sbm = new StarBackup();
        // 两个图片加域名 查所属明星  商家信息
        foreach($res as &$v){

            //广告分类4=>后援会详情广告位 5=>艺人详情广告位 6=>经纪详情广告位
            switch($this->param['status']){
                case 4:
                    $star_id = $sbm->getval(['id'=>$v['obj_id']], 'star_id')['data'];
                    $v['nickname'] = $um->getVal(['id'=>$star_id], 'nickname')['data'];
                break;
                case 5:
                    $v['nickname'] = $um->getVal(['id'=>$v['obj_id']], 'nickname')['data'];
                break;
                case 6:
                    $v['nickname'] = '';
                break;
            }

            $v['stage'] = $stage[$v['stage']];
            $v['position'] = $position[$v['position']];
            $v['status'] = $status[$v['status']];

            // 存储方式  第三方存储  本地服务器存储
            if(strpos($v['img'],'uploads') === false){
                $v['img'] = config('app.qiniu.cdnUrl').$v['img'];
            }else{
                $v['img'] = config('app.url').$v['img'];
            }
            $v['create_time'] = date('Y-m-d H:i:s', $v['create_time']);

            unset($v['obj_type']);
            unset($v['obj_id']);
        }

        $this->result($res, 200, '获取数据成功');
    }
    /**
     * 明星后援会
     * 后援会排行
     */
    public function backup_sort()
    { 
        $result = $this->validate($this->param,'app\common\validate\Artist.backup_sort');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $ssm = new StarStatistics();
        
        $sbm = new StarBackup();

        // 1=>粉丝分成 2=>联盟卡 3=>后援会成员 4=>推广商家数量
        switch($this->param['type']){
            case 1:
                $order = 'divide desc';
            break;
            case 2:
                $order = 'card_number desc';
            break;
            case 3:
                $order = 'fans_number desc';
            break;
            case 4:
                $order = 'business_number desc';
            break;
        }

        // $month_start = strtotime(date("Y-m-01"));
        // $month_end = strtotime("+1 month -1 seconds", $month_start);
        $where = [];
        $where[] = ['star_id', '=', $this->param['id']];
        $where[] = ['status', '=', 1];
        $where[] = ['is_display', '=', 1];
        // $where[] = ['create_time', '>=', $month_start];
        // $where[] = ['create_time', '<=', $month_end];
        $field = 'id, name, logo, fans_number, card_number, business_number';
        $res = $sbm->getList($this->param['page'], $this->param['limit'], $where, $field, $order);

        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 明星后援会
     * 后援会详情
     */
    public function star_backup()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_backup');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $month_start = strtotime(date("Y-m-01"));
        $month_end = strtotime("+1 month -1 seconds", $month_start);

        $where = [];
        $where[] = ['star_id', '=', $this->param['id']];
        $where[] = ['create_time', '>', $month_start];
        $where[] = ['create_time', '<', $month_end];
        $field = 'sb_id as id';
        $res = (new StarSort())->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $sbm = new StarBackup();
        $user = new User();
        foreach($res['data'] as $k=>&$v)
        {
            $res_a = $sbm->getInfo(['id'=>$v['id']], 'name, logo, only, user_id, introduce, fans_number, status, is_display')['data'];

            if($res_a['status'] == 1 && $res_a['is_display'] == 1){

                $res_b = $user->getInfo(['id'=>$res_a['user_id']], 'nickname, only')['data'];

                $v['name'] = $res_a['name'];
                $v['logo'] = $res_a['logo'];
                $v['fans_number'] = $res_a['fans_number'];
                $v['only'] = $res_a['only'];
                $v['introduce'] = $res_a['introduce'];
                $v['user_name'] = $res_b['nickname'];
                $v['user_only'] = $res_b['only'];
                
            }else{
                unset($res['data'][$k]);
            }

        }   

        $this->result($res['data'], 200, '获取数据成功');

    }

    /**
     * 建立明星后援会
     */
    public function add_backup()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.add_backup');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 限制用户建立后援会的数量
        $num = (new Set())->getVal(['id'=>1], 'num')['data'];
        $sbm = new StarBackup();
        $count= $sbm->getCount([['user_id', '=', $this->user_id], ['status', 'in', '0,1']])['data'];
        if($count >= $num){
            $this->result([], 400, '您建立的后援会已达上限,无法建立');
        }

        $data = [
            'user_id'   => $this->user_id,
            'star_id'   => $this->param['user_id'],
            'only'      => $this->only(),
            'name'      => $this->param['name'],
            'logo'      => $this->param['logo'],
            'phone'     => $this->param['phone'],
            'introduce' => $this->param['introduce'],
            'notice'    => $this->param['notice'],
            'other_logo'     => $this->param['other_logo'],
            'other'     => $this->param['other'],
        ];
        $res = $sbm->add($data);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '添加数据成功');

    }
    // 生成后援会唯一only
    private function only()
    {
        $only = only();
        $sbm = new StarBackup();
        $res = $sbm->getInfo(['only'=>$only]);
        if($res['code'] == 200){
            $this->only();
        }
        return $only;
    }

    /**
     * 明星后援会
     * 明星后援会详情
     */
    public function star_backup_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.star_backup_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $sbm = new StarBackup();
        $um = new User();
        $where = [];
        $where[] = ['id', '=', $this->param['id']];
        $field = 'id, name, user_id, logo, only, star_id, fans_number, video, introduce, notice, other_logo, other';
        $res = $sbm->getInfo($where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $star_name = $um->getInfo(['id'=> $res['data']['star_id']], 'nickname, create_time');
        if($star_name['code'] != 200){
            $this->result([], 400, $star_name['msg']);
        }
        $res['data']['star_name'] = $star_name['data']['nickname'];

        $info = $um->getInfo(['id'=>$res['data']['user_id']], 'nickname, head, only, phone');
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }

        $res['data']['president_name'] = $info['data']['nickname'];
        $res['data']['president_head'] = $info['data']['head'];
        $res['data']['president_only'] = $info['data']['only'];
        $res['data']['president_phone'] = $info['data']['phone'];
        $res['data']['president_create_time'] = $star_name['data']['create_time'];

        // 广告位显示 1=>显 0=>隐
        if($this->user_id == $res['data']['user_id']){
            $res['data']['is_advert'] = 1;
        }else{
            $res['data']['is_advert'] = 0;
        }

        unset( $res['data']['star_id']);

        $this->result($res['data'], 200, '获取数据成功');

    }

    /**
     * 明星后援会
     * 明星后援会成员列表
     */
    public function backup_number()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.backup_number');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        $where[] = ['s_id', '=', $this->param['id']];
        $field = 'user_id as id';
        $order = 'contribution desc';
        $res = (new StarBackupMember())->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $um = new User();
        foreach($res['data'] as $v)
        {
            $info = $um->getInfo(['id'=>$v['id']], 'nickname, head, only');
            if($info['code'] != 200){
                continue;
            }
            $v['nickname'] = $info['data']['nickname'];
            $v['head'] = $info['data']['head'];
            $v['only'] = $info['data']['only'];
        }

        $this->result($res['data'], 200, '获取数据成功');

    }

    /**
     * 明星后援会
     * 成员详情
     */
    public function backup_number_info()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.backup_number_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        
        $res_a = (new User())->getInfo(['id'=>$this->param['id']], 'nickname, only');
        if($res_a['code'] != 200){
            $this->result([], 400, $res_a['msg']);
        }
        $res_b = (new StarBackupMember())->getInfo(['s_id'=>$this->param['sb_id'], 'user_id'=>$this->param['id']], 'card, shop, goods, pull');
        if($res_b['code'] != 200){
            $this->result([], 400, $res_b['msg']);
        }

        $data = [
            'nickname' => $res_a['data']['nickname'],
            'only' => $res_a['data']['only'],
            'card' => $res_b['data']['card'],
            'shop' => $res_b['data']['shop'],
            'goods' => $res_b['data']['goods'],
            'pull' => $res_b['data']['pull'],
        ];

        $this->result($data, 200, '获取数据成功');

    }

    /**
     * 明星后援会
     * 分成得主
     */
    public function share_winner()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.share_winner');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new StarBackupMember())->getList(1, 3, ['s_id'=>$this->param['id']], 'user_id','contribution desc');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();
        foreach($res['data'] as $v)
        {
            $info = $um->getInfo(['id'=>$v['user_id']], 'nickname, head');
            if($info['code'] != 200){
                continue;
            }
            $v['nickname'] = $info['data']['nickname'];
            $v['head'] = $info['data']['head'];
            unset($v['user_id']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 明星后援会
     * 加入后援会
     */
    public function join_backup()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.join_backup');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 同一个明星的后援会,只能加入一次  检测

        // 获取用户加入后援会的艺人id
        $res = db('StarBackupMember')
        ->alias('sbm')
        ->join('StarBackup sb','sb.id = sbm.s_id')
        ->where(['sbm.user_id'=>$this->user_id])
        ->field('sb.star_id')
        ->select();
        // 转为一维数组
        $arr = array_column($res, 'star_id');

        // 获取要加入后援会的艺人id
        $sbm = new StarBackup();
        $star_id = $sbm->getVal(['id'=>$this->param['id']], 'star_id');
        if($star_id['code'] != 200){
            $this->result([], 400, $star_id['msg']);
        }

        if(in_array($star_id['data'], $arr)){
            $this->result([], 400, '同一明星下的后援会,只能加入一次');
        }
        // 加入后援会
        $res = (new StarBackupMember())->add(['s_id'=>$this->param['id'], 'user_id'=>$this->user_id]);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        // 后援会粉丝加一
        $sbm->setIncField(['id'=>$this->param['id']], 'fans_number');
        // 艺人粉丝加一
        (new Star())->setIncField(['user_id'=>$star_id['data']], 'fans_number');

        $this->result([], 200, '加入成功');
    }
    
    /**
     * 商务合作
     */
    public function business_cooperation()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.business_cooperation');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $data = $this->param;
        $data['obj_id'] = $this->param['id'];
        // 1=>针对明星合作的 2=>针对后援会的 3=>针对经纪公司
        $data['obj_type'] = $this->param['type'];
        unset($data['id']);
        unset($data['type']);
        unset($data['token']);


        $res = (new BusinessCooperation())->add($data);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '添加成功');
    }

    /**
     * 经纪公司
     */
    public function company()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.company');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 检测是否加入经纪公司
        $is_res = (new BrokerageAgencyMember())->getInfo(['user_id'=>$this->param['user_id'], 'status'=>1], 'b_id');
        if($is_res['code'] != 200){
            $this->result([], 400, '暂时未加入经纪公司');
        }

        $field = 'id, name, only, logo, introduce, other_logo, other';
        $res = (new BrokerageAgency())->getInfo(['id'=>$is_res['data']['b_id']], $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取成功');
    }

    /**
     * 经纪公司下
     * 公司艺人
     */
    public function company_artist()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.company_artist');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        $where[] = ['b_id', '=', $this->param['id']];
        $where[] = ['status', '=', 1];
        if($this->param['type'] != 0){
            $where[] = ['type', '=', $this->param['type']];
        }
        $field = 'user_id';
        $res = (new BrokerageAgencyMember())->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();
        $sm = new Star();
        $sem = new StarEntourage();
        foreach($res['data'] as &$v)
        {
            $res_a = $um->getInfo(['id'=>$v['user_id']], 'id, nickname, head, only');
            $res_b = $sm->getInfo(['user_id'=>$v['user_id']], 'fans_number, backup_number');
            $res_c = $sem->getInfo(['user_id'=>$v['user_id'], 'job'=>1], 'name');
            $v['id'] = $res_a['data']['id'];
            $v['nickname'] = $res_a['data']['nickname'];
            $v['head'] = $res_a['data']['head'];
            $v['only'] = $res_a['data']['only'];
            $v['agent'] = $res_c['data']['name'];
            $v['fans_number'] = $res_b['data']['fans_number'];
            $v['backup_number'] = $res_b['data']['backup_number'];

            unset($v['user_id']);
        }
        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 联盟商品下
     * 明星联盟列表
     */
    public function union_list()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.union_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = [];
        $where[] = ['type', '=', 1];
        $where[] = ['status', '=', 1];
        $where[] = ['is_display', '=', 1];
        $where[] = ['user_id', '=', $this->param['id']];
        $field = 'id, only, name, logo, union_type, u_id, union_card_name, union_card_logo, union_card_price, union_card_discount, union_card_style, business_number, create_time';

        $res = (new Union())->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 联盟商品
     * 投票列表
     */
    public function vote_list()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.vote_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new UnionClass())->getList(0, 0, [], 'id, title, logo');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        // 检测是否投过票 0=>没投过 1=>已投 
        $res_v = (new UnionVoteLog())->getInfo(['star_id'=>$this->param['id'], 'user_id'=>$this->user_id], 'un_id');
        if($res_v['code'] != 200){
            $data = [
                'status' => 0,
            ];
        }else{
            $data = [
                'status' => 1,
                'un_id'  => $res_v['data']['un_id'],  // 投的分类id
            ];
        }
        $this->result(['data'=>$data, 'class'=>$res['data']], 200, '获取数据成功');
    }

    /**
     * 联盟商品
     * 投票, 每个明星一个投票数
     */
    public function vote()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.vote');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $uvm = new UnionVote();
        $data = ['star_id'=>$this->param['user_id'], 'un_id'=>$this->param['id'], 'status'=>0];
        $is_res = $uvm->getInfo($data, 'id');
        if($is_res['code'] != 200){
            $id = $uvm->add($data);
            $uvm->setIncField(['id'=>$id], 'votes');
        }else{
            $uvm->setIncField(['id'=>$is_res['data']['id']], 'votes');
        }

        // 加已投记录
        (new UnionVoteLog)->add(['star_id'=>$this->param['user_id'], 'user_id'=>$this->user_id, 'un_id'=>$this->param['id']]);

        $this->result([], 200, '投票成功');
    }

    /**
     * 投票记录
     */
    public function vote_log()
    {
        $result = $this->validate($this->param,'app\common\validate\Artist.vote_log');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $month_start = strtotime($this->param['start_time']);
        $month_end = strtotime("+1 month -1 seconds", $month_start);

        $where = [];
        $where[] = ['star_id', '=', $this->param['user_id']];
        $where[] = ['create_time', '>', $month_start];
        $where[] = ['create_time', '<', $month_end];

        $field = 'un_id, votes';
        $order = 'votes desc';
        $res = (new UnionVote())->getList(1, 10, $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        foreach($res['data'] as &$v)
        {
            $v['title'] = $v['un_id']['title'];
            $v['logo'] = $v['un_id']['logo'];
            unset($v['un_id']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }
}
