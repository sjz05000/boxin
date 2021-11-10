<?php

namespace app\capi\controller;

use think\Controller;

use app\common\controller\Base;

use app\common\model\User;

use app\common\model\NoticeNews;  // 各种消息表
use app\common\model\NoticeBackup;
use app\common\model\NoticeUserC;
use app\common\model\NoticeUnion;
use app\common\model\NoticeBusiness;

use app\common\model\StarBackup;  // 后援会表
use app\common\model\StarBackupMember;

use app\common\model\UserCollection; // 用户收藏

use app\common\model\UserUnionCard;
use app\common\model\Business; // 店铺
use app\common\model\Union; // 联盟

use app\common\model\BrokerageAgency; // 经纪公司
use app\common\model\BrokerageAgencyMember;
// use app\common\model\;
// use app\common\model\;
// use app\common\model\;
use think\Db;

// 消息
class News extends Base
{
    /**
     * 4种通知消息
     * 小红点提示
     */
    public function red_msg()
    {
        // 获取用户已读信息
        $relation = new NoticeUserC();
        $user_info = $relation->getInfo(['user_id'=>$this->user_id]);
        if($user_info['code'] != 200){
            $relation->add(['user_id'=>$this->user_id]);
        }
        $user_info = $relation->getInfo(['user_id'=>$this->user_id]);

        // 重要通知 开始
        $c = $this->arr_id();
        // 获取重要消息的 已读字段
        if($user_info['data']['nn_id'] == null){
            $arr = [];
        }else{
            $arr = json_decode($user_info['data']['nn_id']);
        }
        // 判断两个数组是否相同
        if(empty(array_diff($c, $arr))){
            $a = 0;
        }else{
            $a = 1;
        }
        // 重要通知 结束

        // 后援会通知 开始
        // 获取用户加入的所有后援会 id
        $b_id = (new StarBackupMember)->getCol(['user_id'=>$this->user_id], 's_id');
        if($b_id['code'] != 200){
            $this->result([], 400, $b_id['msg']);
        }
        // 获取加入的后援会,发布的消息 id
        $arr_sid = (new NoticeBackup)->getCol([['s_id', 'in', $b_id['data']]], 'id');
        if($arr_sid['code'] != 200){
            $this->result([], 400, $arr_sid['msg']);
        }
        // 获取消息的 已读字段
        if($user_info['data']['nbu_id'] == null){
            $arr = [];
        }else{
            $arr = json_decode($user_info['data']['nbu_id']);
        }
      
        // 判断两个数组是否相同
        if(empty(array_diff($arr_sid['data'], $arr))){
            $b = 0;
        }else{
            $b = 1;
        }
        // 后援会通知 结束

        // 店铺通知 开始
        // 获取关注的店铺 id
        $b_id = (new UserCollection())->getCol(['user_id'=>$this->user_id, 'obj_type'=>1,], 'obj_id');
        if($b_id['code'] != 200){
            $this->result([], 400, $b_id['msg']);
        }
        // 获取店铺发布的消息 id
        $arr_bid = (new NoticeBusiness())->getCol([['type','=',1], ['b_id','in', $b_id['data']]], 'id');
        if($arr_bid['code'] != 200){
            $this->result([], 400, $arr_bid['msg']);
        }
        // 获取消息的 已读字段
        if($user_info['data']['nbs_id'] == null){
            $arr = [];
        }else{
            $arr = json_decode($user_info['data']['nbs_id']);
        }
        // 判断两个数组是否相同
        if(empty(array_diff($arr_bid['data'], $arr))){
            $c = 0;
        }else{
            $c = 1;
        }
        // 店铺通知 结束

        // 联盟通知 开始
        // 获取购买过的联盟卡的联盟id
        $u_id = (new UserUnionCard)->getCol(['user_id'=>$this->user_id], 'u_id');
        if($u_id['code'] != 200){
            $this->result([], 400, $u_id['msg']);
        }
        // 获取该联盟发的信息 id
        $arr_uid = (new NoticeUnion())->getCol([['type','=',1], ['u_id','in', $u_id['data']]], 'id');
        if($arr_uid['code'] != 200){
            $this->result([], 400, $arr_uid['msg']);
        }
        // 获取消息的 已读字段
        if($user_info['data']['nuu_id'] == null){
            $arr = [];
        }else{
            $arr = json_decode($user_info['data']['nuu_id']);
        }
        // 判断两个数组是否相同
        if(empty(array_diff($arr_uid['data'], $arr))){
            $d = 0;
        }else{
            $d = 1;
        }
        // 联盟通知 结束
       
        //  0 =>无小红点 1 =>显示小红点
        $data = [
            'notice_news'      => $a,   // 重要通知
            'notice_backup'    => $b,   //后援会通知
            'notice_business'  => $c,   // 店铺通知
            'notice_union'     => $d,   // 联盟通知
        ];

        $this->result($data, 200, '获取成功');
    }
    
    /**
     * 4种通知消息列表
     */
    public function notice_list()
    {

        $result = $this->validate($this->param,'app\common\validate\News.notice_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 获取用户已读信息
        $info = (new NoticeUserC)->getInfo(['user_id'=>$this->user_id]);
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }
        // 重要消息
        $important = $info['data']['nn_id'] == null ? [] : json_decode($info['data']['nn_id']);
        // 后援会消息
        $backup = $info['data']['nbu_id'] == null ? [] : json_decode($info['data']['nbu_id']);
        // 店铺消息
        $shop = $info['data']['nbs_id'] == null ? [] : json_decode($info['data']['nbs_id']);
        // 联盟消息
        $union = $info['data']['nuu_id'] == null ? [] : json_decode($info['data']['nuu_id']);

        // is_read 1=>无红点(已读) 2=>有红点(未读)
        switch($this->param['type']){
            // 重要消息
            case 1: 
                // 获取重要消息 id
                $c = $this->arr_id();
                $list = (new NoticeNews)->getList($this->param['page'], $this->param['limit'], [['type', '=', 1], ['id', 'in', $c]], 'id, content, create_time, class, user_id', 'id desc');
                if($list['code'] != 200){
                    $this->result([], 400, $list['msg']);
                }
                
                // 0=>平台发布的(b,c端) 1=>经纪公司发布(c 端) 2=>艺人(c 端)  3=>指针对1个用户的
                // 0  3名称 logo 为 平台 
                // 1  2发布者名称 logo
                $bam = new BrokerageAgency();
                $um = new User();
                foreach($list['data'] as &$v)
                {
                    $v['content'] = mb_substr(preg_replace("/(\s|\&nbsp\;|　|\xc2\xa0)/", " ",strip_tags($v['content'])),0,10,'utf-8');

                    switch($v['class']){

                        case 0:
                            $v['logo'] = config('app.url').'storage/notice.jpg';
                            $v['name'] = '平台';
                        break;

                        case 1:
                            $res_a = $bam->getInfo(['id'=>$v['user_id']], 'name, logo')['data'];
                            $v['logo'] = $res_a['logo'];
                            $v['name'] = $res_a['name'];
                        break;

                        case 2:
                            $res_a = $um->getInfo(['id'=>$v['user_id']], 'nickname, head')['data'];
                            $v['logo'] = $res_a['head'];
                            $v['name'] = $res_a['nickname'];
                        break;

                        case 3:
                            $v['logo'] = config('app.url').'storage/notice.jpg';
                            $v['name'] = '平台';
                        break;
                    }

                    if(in_array($v['id'], $important)){
                        $v['is_read'] = 1;
                    }else{
                        $v['is_read'] = 2;
                    }

                    unset($v['class']);
                    unset($v['user_id']);
                }
            break;
            // 后援会消息
            case 2: 

                // 获取用户加入的后援会id
                $b_id = (new StarBackupMember)->getCol(['user_id'=>$this->user_id], 's_id');
                if($b_id['code'] != 200){
                    $this->result([], 400, $b_id['msg']);
                }

                // 后援会消息表
                $list = (new NoticeBackup)->getList($this->param['page'], $this->param['limit'], [['s_id', 'in', $b_id['data']]], 'id, s_id, content, create_time', 'id desc');
                if($list['code'] != 200){
                    $this->result([], 400, $list['msg']);
                }

                $sbm = new StarBackup();
                foreach($list['data'] as &$v)
                {
                    $info = $sbm->getInfo(['id'=>$v['s_id']], 'logo, name');
                    $v['content'] = mb_substr(preg_replace("/(\s|\&nbsp\;|　|\xc2\xa0)/", " ",strip_tags($v['content'])),0,10,'utf-8');
                    $v['logo'] = $info['data']['logo'];
                    $v['name'] = $info['data']['name'];
                    if(in_array($v['id'], $backup)){
                        $v['is_read'] = 1;
                    }else{
                        $v['is_read'] = 2;
                    }
                    unset($v['s_id']);
                }
            break;
            // 店铺消息
            case 3: 
                // 获取关注的店铺 id
                $b_id = (new UserCollection())->getCol(['user_id'=>$this->user_id, 'obj_type'=>1,], 'obj_id');
                if($b_id['code'] != 200){
                    $this->result([], 400, $b_id['msg']);
                }

                // 获取关注店铺发布的消息 id
                $list = (new NoticeBusiness())->getList($this->param['page'], $this->param['limit'], [ ['type', '=', 1], ['b_id', 'in', $b_id['data']] ], 'id, b_id, content, create_time', 'id desc');
                if($list['code'] != 200){
                    $this->result([], 400, $list['msg']);
                }

                $bm = new Business();
                foreach($list['data'] as &$v)
                {
                    $info = $bm->getInfo(['id'=>$v['b_id']], 'logo, name');
                    $v['content'] = mb_substr(preg_replace("/(\s|\&nbsp\;|　|\xc2\xa0)/", " ",strip_tags($v['content'])),0,10,'utf-8');
                    $v['logo'] = $info['data']['logo'];
                    $v['name'] = $info['data']['name'];
                    if(in_array($v['id'], $shop)){
                        $v['is_read'] = 1;
                    }else{
                        $v['is_read'] = 2;
                    }
                    unset($v['b_id']);
                }
            break;
            // 联盟消息
            case 4: 
                // 获取购买联盟卡的联盟 id
                $u_id = (new UserUnionCard)->getCol(['user_id'=>$this->user_id], 'u_id');
                if($u_id['code'] != 200){
                    $this->result([], 400, $u_id['msg']);
                }

                // 获取联盟发的消息 id
                $list = (new NoticeUnion())->getList($this->param['page'], $this->param['limit'], [ ['type', '=', 1], ['u_id', 'in', $u_id['data']]], 'id, u_id, content, create_time', 'id desc');
                if($list['code'] != 200){
                    $this->result([], 400, $list['msg']);
                }

                foreach($list['data'] as &$v)
                {
                    $info = (new Union())->getInfo(['id'=>$v['u_id']], 'logo, name');
                    $v['content'] = mb_substr(preg_replace("/(\s|\&nbsp\;|　|\xc2\xa0)/", " ",strip_tags($v['content'])),0,10,'utf-8');
                    $v['logo'] = $info['data']['logo'];
                    $v['name'] = $info['data']['name'];
                    if(in_array($v['id'], $union)){
                        $v['is_read'] = 1;
                    }else{
                        $v['is_read'] = 2;
                    }
                    unset($v['u_id']);
                }
            break;
        }

        $this->result($list['data'], 200, '获取成功');
    }

    /**
     * 通知消息详情
     */
    public function notice_info()
    {
        $result = $this->validate($this->param,'app\common\validate\News.notice_info');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        
        // 获取用户已读信息
        $nucm = new NoticeUserC();
        $info = $nucm->getInfo(['user_id'=>$this->user_id]);
        if($info['code'] != 200){
            $this->result([], 400, $info['msg']);
        }

        // 添加用户已读
        switch($this->param['type']){
            case 1:
                // 重要消息
                $important = $info['data']['nn_id'] == null ? [] : json_decode($info['data']['nn_id']);

                if(!in_array($this->param['id'], $important)){

                    array_push($important, $this->param['id']);
                    $nucm->edit(['id'=>$info['data']['id'], 'nn_id'=>json_encode($important)]);

                }

                $res = (new NoticeNews())->getInfo(['id'=>$this->param['id']], 'content, create_time');
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }
            break;
            case 2:
                // 后援会消息
                $backup = $info['data']['nbu_id'] == null ? [] : json_decode($info['data']['nbu_id']);

                if(!in_array($this->param['id'], $backup)){

                    array_push($backup, $this->param['id']);
                    $nucm->edit(['id'=>$info['data']['id'], 'nbu_id'=>json_encode($backup)]);
                }

                $res = (new NoticeBackup())->getInfo(['id'=>$this->param['id']], 's_id, content, create_time');
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }

                $data =(new StarBackup())->getInfo(['id'=>$res['data']['s_id']], 'logo, name');
                $res['data']['logo'] = $data['data']['logo'];
                $res['data']['name'] = $data['data']['name'];
                unset($res['data']['s_id']);
            break;
            case 3:
                // 店铺消息
                $shop = $info['data']['nbs_id'] == null ? [] : json_decode($info['data']['nbs_id']);

                if(!in_array($this->param['id'], $shop)){

                    array_push($shop, $this->param['id']);
                    $nucm->edit(['id'=>$info['data']['id'], 'nbs_id'=>json_encode($shop)]);
                }

                $res = (new NoticeBusiness())->getInfo(['id'=>$this->param['id']], 'b_id, content, create_time');
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }

                $data = (new Business())->getInfo(['id'=>$res['data']['b_id']], 'logo, name');
                $res['data']['logo'] = $data['data']['logo'];
                $res['data']['name'] = $data['data']['name'];
                unset($res['data']['b_id']);
            break;
            case 4:
                // 联盟消息
                $union = $info['data']['nuu_id'] == null ? [] : json_decode($info['data']['nuu_id']);

                if(!in_array($this->param['id'], $union)){

                    array_push($union, $this->param['id']);
                    $nucm->edit(['id'=>$info['data']['id'], 'nuu_id'=>json_encode($union)]);

                }

                $res = (new NoticeUnion())->getInfo(['id'=>$this->param['id']], 'u_id, content, create_time');
                if($res['code'] != 200){
                    $this->result([], 400, $res['msg']);
                }

                $data = (new Union())->getInfo(['id'=>$res['data']['u_id']], 'logo, name');
                $res['data']['logo'] = $data['data']['logo'];
                $res['data']['name'] = $data['data']['name'];
                unset($res['data']['u_id']);
            break;
        }

        $this->result($res['data'], 200, '获取成功');
    }

    /**
     * c 端首页 消息内
     * 获取重要消息的id,复用,
     * 返回的数据是 当前用户 重要消息表的 id 数组
     */
    private function arr_id()
    {
        // 重要通知 开始
        $nnm = new NoticeNews();
        // 重要消息里4类:平台发的 经纪公司发的 艺人发的  只通知1人的
        // class 0=>平台发布的(b,c端) 1=>经纪公司发布(c 端) 2=>艺人(c 端)  3=>针对1个用户的

        // 1.平台发的 范围所有用户 不用判断
        $n_id = $nnm->getCol(['type'=>1, 'class'=>0], 'id');
        if($n_id['code'] != 200){
            $this->result([], 400, $n_id['msg']);
        }

        // 2.经纪公司通知相关消息,只针对该公司认证过的艺人  需要判断
            // 判断当前用户是艺人否,
            // 是艺人,是经纪公司认证的吗 
            // 判断用户在经纪公司成员表里吗 在说明是艺人,也是通过公司认证, 获取经纪公司的id
            $res_ba = (new BrokerageAgencyMember())->getCol(['user_id'=>$this->user_id, 'status'=>1], 'b_id')['data'];
        $res_bam = $nnm->getCol([['type', '=', 1], ['class', '=', 1], ['user_id', 'in', $res_ba]], 'id')['data'];

        // 3.艺人通知相关消息, 只针对关注该艺人的用户,加入为该明星的后援会用户    需要判断
            // 查当前用户关注艺人id,
            $res_ucm = (new UserCollection())->getCol(['user_id'=>$this->user_id, 'obj_type'=>2], 'obj_id')['data'];
            // 获取用户加入明星后援会的明星id
            $res_sbm = db('StarBackupMember')
            ->alias('sb')
            ->join('StarBackup s','s.id = sb.s_id')
            ->where(['sb.user_id'=>$this->user_id])
            ->column('s.star_id');
            $arr = array_merge($res_ucm, $res_sbm);
            $arr = array_unique($arr);
        $res_nt = $nnm->getCol([['type', '=', 1], ['class', '=', 2], ['user_id', 'in', $arr]], 'id')['data'];

        // 4.只通知1人的    需要判断
        $res_ns = $nnm->getCol(['type'=>1, 'class'=>3, 'to_user_id'=>$this->user_id], 'id')['data'];
        
        $c = array_merge($n_id['data'], $res_bam, $res_nt, $res_ns);   // 合并
        $c = array_unique($c);      // 去重
        return $c;
    }
}
