<?php

namespace app\capi\controller;

use think\Controller;
use app\common\controller\Base;

use app\common\model\User;
use app\common\model\UserCollection; // 用户收藏
use app\common\model\UserFootprint; // 足迹表
use app\common\model\UserUnionCard;
use app\common\model\UserQrcode;
use app\common\model\Business;    // 商家表
use app\common\model\Star;         // 明星
use app\common\model\StarBackup;
use app\common\model\StarBackupMember;
use app\common\model\StarEntourage;
use app\common\model\StartAuth;  // 明星平台认证审核表
use app\common\model\Union;     // 联盟
use app\common\model\BrokerageAgency; // 经纪公司
use app\common\model\BrokerageAgencyMember;
use app\common\model\Apk;     // 安装包表
use app\common\model\MoneyLog;
use app\common\model\NoticeNews; // 重要消息

use app\common\model\BusinessCooperation; // 合作表


use think\Db;


// use app\common\model\;
// use app\common\model\;
// use app\common\model\;

class My extends Base
{

    /**
     * 个人信息
     */
    public function user_info()
    {
        $res = (new User())->getInfo(['id'=>$this->user_id], 'id, nickname, head, only, money, is_c_user, is_company, is_star, name_num, head_num');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        // 加入/建立的后援会数量
        // 加入的
        $where[] = ['s.status', '=', 1];
        $where[] = ['sb.user_id', '=', $this->user_id];
        $res_a = db('StarBackupMember')
        ->alias('sb')
        ->join('StarBackup s', 'sb.s_id = s.id')
        ->where($where)
        ->count();
        // 建立的
        $sbm = new StarBackup();
        $res_b = $sbm->getCount(['user_id'=>$this->user_id]);
        if($res_b['code'] != 200){
            $this->result([], 400, $res_b['msg']);
        }

        $res['data']['join'] = $res_a;
        $res['data']['add'] = $res_b['data'];

        $this->result($res['data'], 200, '获取数据成功');

    }

    /**
     * 头像/昵称修改
     */
    public function info_edit()
    {
        $um = new User();

        if($this->param['type'] == 1){
            $res = $um->edit(['id'=>$this->user_id, 'head'=>$this->param['img'], 'head_num'=>0]);
        }else{
            $res = $um->edit(['id'=>$this->user_id, 'nickname'=>$this->param['nickname'], 'name_num'=>0]);
        }
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '修改成功');
    }

    /**
     * 昵称修改
     */
    public function name_edit()
    {

    }

    /**
     * 收藏的明星/商家
     */
    public function collect_list()
    {
        $result = $this->validate($this->param,'app\common\validate\My.collect_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = ['user_id'=>$this->user_id, 'obj_type'=>$this->param['type']];
        $res = (new UserCollection())->getList($this->param['page'], $this->param['limit'], $where, 'obj_id', 'id desc');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 1=>店铺 2=>明星
        if($this->param['type'] ==1 ){
            foreach($res['data'] as $v)
            {
                $info = (new Business())->getInfo(['id'=>$v['obj_id']], 'id, name, logo');
                $v['id'] = $info['data']['id'];
                $v['name'] = $info['data']['name'];
                $v['logo'] = $info['data']['logo'];
                unset($v['obj_id']);
            }
        }else{
            foreach($res['data'] as $v)
            {
                $info = (new User())->getInfo(['id'=>$v['obj_id']], 'id, nickname, head');
                $v['id'] = $info['data']['id'];
                $v['name'] = $info['data']['nickname'];
                $v['logo'] = $info['data']['head'];
                unset($v['obj_id']);
            }
        }
        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 足迹
     */
    public function footprint()
    {

        $result = $this->validate($this->param,'app\common\validate\My.limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        
        $where = [];
        $where[] = ['obj_type', '=', $this->param['type']];
        $where[] = ['user_id', '=', $this->user_id];
        $field = 'id, obj_id, day';
        $order = 'day desc';

        $ufm = new UserFootprint();
        $day = $ufm->where($where)->field($field)->order($order)->group('day')->page($this->param['page'], $this->param['limit'])->select();
        if(empty($day[0]['day'])){
            $this->result([], 200, '获取数据成功');
        }

        $where[] = ['day', '=', $day[0]['day']];
        $arr_id = $ufm->getList(0, 0, $where, 'id, obj_id', 'id desc');
        if($arr_id['code'] != 200){
            $this->result([], 400, $arr_id['msg']);
        }

        // 1=>联盟 2=>店铺 3=>明星
        switch($this->param['type']){
            case 1:
                $mm = new Union();
            break;
            case 2: 
                $mm = new Business();
            break;
            case 3:
                $mm = new user();
                $sm = new Star();
            break;
        }
        foreach($arr_id['data'] as &$v)
        {
            if($this->param['type'] != 3){

                $info = $mm->getInfo(['id'=>$v['obj_id']], 'name, logo, only');
                if($info['code'] != 200){
                    continue;
                }
                $v['name'] = $info['data']['name'];
                $v['logo'] = $info['data']['logo'];
                $v['only'] = $info['data']['only'];

            }else{

                $info_a = $mm->getInfo(['id'=>$v['obj_id']], 'nickname, head, only');
                if($info_a['code'] != 200){
                    continue;
                }
                $info_b = $sm->getInfo(['id'=>$v['obj_id']], 'backup_number, fans_number');
                if($info_b['code'] != 200){
                    continue;
                }

                $v['name'] = $info_a['data']['nickname'];
                $v['logo'] = $info_a['data']['head'];
                $v['only'] = $info_a['data']['only'];
                $v['backup_number'] = $info_b['data']['backup_number'];
                $v['fans_number'] = $info_b['data']['fans_number'];

            }
        }

        $data = [
            'day' => $day[0]['day'] == date('Y-m-d', time()) ? '今天'  : $day[0]['day'],
            'data' => $arr_id['data'],
        ];
        $this->result($data, 200, '获取数据成功');



    }

    /**
     * 足迹删除
     */
    public function footprint_del()
    {
        $result = $this->validate($this->param,'app\common\validate\My.footprint_del');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new UserFootprint())->del($this->param['del_id']);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '删除成功');
    }

    /**
     * 联盟卡
     */
    public function card_list()
    {
        $result = $this->validate($this->param,'app\common\validate\My.card_list');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where = ['uu.user_id'=>$this->user_id, 'uu.status'=>$this->param['type']];
        $field = '';
        $res = (new UserUnionCard())->class_search($this->param['page'], $this->param['limit'], $where);
        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 联盟卡推广二维码
     */
    public function card_share()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $uqm = new UserQrcode();

        
    }

    /**
     * 设置
     * 更新版本
     */
    public function version_update()
    {
        $result = $this->validate($this->param,'app\common\validate\My.version_update');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where[] = ['type', '=', $this->param['type']]; // 1=>c 端 2=>b 端
        $where[] = ['client_type', '=', $this->param['status']]; // 1=>Android  2=>IOS
        $filed = 'server_version, app_link';
        $res = (new Apk())->getInfo($where, $filed);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        if($res['data']['server_version'] != $this->param['del_id']){
            $data = [
                'status'=>1,   // 1 要更新
                'link'=>$res['data']['app_link'],
            ];
        }else{
            $data = [
                'status'=>0,   // 0 不需要更新
                'link'=>$res['data']['app_link'],
            ];
        }
        $this->result($data, 200, '获取数据成功');
    }

    /**
     * 余额
     * 查看明细
     */
    public function money_log()
    {
        $result = $this->validate($this->param,'app\common\validate\My.limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where[] = ['user_id', '=', $this->user_id];
        $where[] = ['type', '=', 1];
        $field = 'id, money, describe, create_time, operation';
        $order = 'id desc';
        $res = (new MoneyLog())->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        foreach($res['data'] as &$v)
        {
            if($v['operation'] == 0){
                $v['money'] = '-'.$v['money'];
            }else{
                $v['money'] = '+'.$v['money'];
            }
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 余额
     * 明细详情
     */
    public function money_log_info()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new MoneyLog())->getInfo(['id'=>$this->param['id']], 'money, describe, create_time, balance, operation,money_type');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        if($res['data']['operation'] == 0){
            $res['data']['money'] = '-'.$res['data']['money'];
        }else{
            $res['data']['money'] = '+'.$res['data']['money'];
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 后援会管理
     * 加入/建立的后援会
     */
    public function backup_list()
    {
        $result = $this->validate($this->param,'app\common\validate\My.limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $field= 's.id, s.name, s.logo, s.only, s.fans_number, u.nickname as user_name, u.only as user_only, s.is_display, s.status';

        // 1=>加入的后援会 2=>创建的后援会
        if($this->param['type'] == 1){
            $where[] = ['s.status', '=', 1];
            $where[] = ['sb.user_id', '=', $this->user_id];
            
            $res = db('StarBackupMember')
            ->alias('sb')
            ->join('StarBackup s', 'sb.s_id = s.id')
            ->join('User u', 's.user_id = u.id')
            ->where($where)
            ->field($field)
            ->page($this->param['page'], $this->param['limit'])
            ->select();

        }else{

            $where[] = ['s.user_id', '=', $this->user_id];

            $res = db('StarBackup')
            ->alias('s')
            ->join('User u', 's.user_id = u.id')
            ->where($where)
            ->field($field)
            ->page($this->param['page'], $this->param['limit'])
            ->select();

        }

        foreach($res as &$v)
        {
            if(strpos($v['logo'],'uploads') === false){
                $v['logo'] = config('app.qiniu.cdnUrl').$v['logo'];
            }else{
                $v['logo'] = config('app.url').$v['logo'];
            }
        }
       

        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 后援会管理
     * 商务合作记录
     */
    public function cooperate_log()
    {
        // 获取用户创建的后援会id
        $arr_id = (new StarBackup())->getCol(['user_id'=>$this->user_id], 'id');

        $where[] = ['obj_type', '=', 2];
        $where[] = ['obj_id', 'in', $arr_id['data']];
        $field = 'company, name, phone, content';
        $order = 'id desc';
        $res = (new BusinessCooperation())->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 后援会管理
     * 管理后援会
     */
    public function backup_info()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $sbm = new StarBackup();
        $res = $sbm->getInfo(['id'=>$this->param['id']], 'id, star_id, only, name, logo, phone, introduce, notice, other_logo, other');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }
        $sm = new User();
        $res['data']['star_name'] = $sm->getVal(['id'=>$res['data']['star_id']], 'nickname')['data'];

        unset($res['data']['star_id']);

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 后援会管理
     * 管理后援会(修改)
     */
    public function backup_edit()
    {
        $result = $this->validate($this->param,'app\common\validate\My.backup_edit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $res = (new StarBackup())->edit($this->param);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '修改成功');

    }
    
    /**
     * 我的记录
     * 联盟卡分成
     */
    public function card_divide()
    {
        $result = $this->validate($this->param,'app\common\validate\My.limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }


    }

    /**
     * 经纪公司
     * 列表
     */
    public function company_list()
    {
        $result = $this->validate($this->param,'app\common\validate\My.limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $bam = new BrokerageAgency();

        if(!empty($this->param['search'])){
            $where[] = ['name|only', 'like', '%'.$this->param['search'].'%'];
        }
        
        $where[] = ['status', '=', 1];
        $where[] = ['is_display', '=', 1];

        $field = 'id, name, logo, only, people, phone, user_id';
        $res = $bam->getList($this->param['page'], $this->param['limit'], $where, $field);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $um = new User();
        // 加建立者信息, 粉丝量
        foreach($res['data'] as &$v)
        {
            $user_info = $um->getInfo(['id'=>$v['user_id']], 'nickname, only');

            $v['user_name'] = $user_info['data']['nickname'];
            $v['user_only'] = $user_info['data']['only'];
            
            $v['fans'] = $this->fans($v['id']);

            unset($v['user_id']);
        }


        $this->result($res['data'], 200, '获取数据成功');
    }
    // 获取经济公司内艺人加起来的粉丝量 $id 为 经济公司id
    private function fans($id)
    {   
        $bamm = new BrokerageAgencyMember();
        $arr_id = $bamm->getCol(['b_id'=>$id, 'status'=>1], 'user_id');
        if($arr_id['code'] != 200){
            $this->result([], 400, $arr_id['msg']);
        }

        $sm = new Star();
        $res = $sm->getSum([ ['user_id', 'in', $arr_id['data'], ['is_display', '=', 1]] ], 'fans_number');
        return $res['data'];
    }
    
    /**
     * 经纪公司
     * 管理下
     * 经纪公司详情
     */
    public function company_info()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        
        $bam = new BrokerageAgency();
        $res = $bam->getInfo(['id'=>$this->param['id']], 'id, name, logo, only, people, phone, introduce, notice, other_logo, other, pwd');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 经济公司
     * 管理
     * 修改
     */
    public function company_edit()
    {
        $result = $this->validate($this->param,'app\common\validate\My.company_edit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $bam = new BrokerageAgency();
        $res = $bam->edit($this->param);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '修改成功');

    }

    /**
     * 经纪公司
     * 管理
     * 需合作艺人
     */
    public function apply()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id_limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        if(!empty($this->param['search'])){
            $where[] = ['u.nickname|u.only', 'like', '%'.$this->param['search'].'%'];
        }

        if($this->param['type'] != 0){
            $where[] = ['b.type', '=', $this->param['type']];
        }

        $where[] = ['b.b_id', '=', $this->param['id']];
        $where[] = ['b.status', '=', 0];

        $field = 'b.user_id as id, b.type, u.nickname, u.head, u.only, u.phone, s.backup_number, s.fans_number';
        $order = 'id desc';

        $res = db('BrokerageAgencyMember')
        ->alias('b')
        ->join('User u', 'b.user_id = u.id')
        ->join('Star s', 'b.user_id = s.user_id')
        ->where($where)
        ->field($field)
        ->order($order)
        ->page($this->param['page'], $this->param['limit'])
        ->select();

        $arr = [1=>'内部', 2=>'外部'];
        foreach($res as &$v)
        {
            $v['type'] = $arr[$v['type']];

            if(strpos($v['head'],'uploads') === false){
                $v['head'] = config('app.qiniu.cdnUrl').$v['head'];
            }else{
                $v['head'] = config('app.url').$v['head'];
            }
        }
        
        $this->result($res, 200, '获取数据成功');
        
    }

    /**
     * 经纪公司
     * 管理
     * 需合作艺人
     * 查看
     */
    public function apply_info()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $where[] = ['s.user_id', '=', $this->param['id']];
        $field = 'b.id, b.type, u.nickname, u.head, u.only, u.phone, s.backup_number, s.fans_number, s.content';
        $res = db('Star')
        ->alias('s')
        ->join('User u', 's.user_id = u.id')
        ->join('BrokerageAgencyMember b', 's.user_id = b.user_id')
        ->where($where)
        ->field($field)
        ->find();

        $type = [1=>'内部', 2=>'外部'];
        $res['type'] = $type[$res['type']];

        // 加域名
        if(strpos($res['head'],'uploads') === false){
            $res['head'] = config('app.qiniu.cdnUrl').$res['head'];
        }else{
            $res['head'] =  config('app.url').$res['head'];
        }

        // 随从
        $sem = new StarEntourage();
        $res['list'] = $sem->getList(0, 0, ['user_id'=>$this->param['id']], 'job, name, head')['data'];

        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 经纪公司
     * 管理
     * 需合作艺人
     * 同意/拒绝
     */
    public function is_yes_no()
    {
        $result = $this->validate($this->param,'app\common\validate\My.is_yes_no');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $bamm = new BrokerageAgencyMember();

        // 申请者id
        $user_id = $bamm->getInfo(['id'=>$this->param['id']], 'b_id, user_id');

        if($this->param['type'] == 1){
            // 检测申请是否加入别的经纪公司否
            $is_res = $bamm->getInfo(['user_id'=>$user_id['data']['user_id'], 'status'=>1]);
            if($is_res['code'] == 200){
                $this->result([], 400, '该用户已加入其它公司');
            }
        }

        $res = $bamm->edit(['id'=>$this->param['id'], 'status'=>$this->param['type']]);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 发通知
        $nnm = new NoticeNews();

        // 获取通知名称
        $bam = new BrokerageAgency();

        $name = $bam->getInfo(['id'=>$user_id['data']['b_id']], 'name');
        if($this->param['type'] == 1){
            $content = '<p> 您好，恭喜您，您申请加入【'.$name['data']['name'].'】的申请已被通过。</p>';
        }else{
            $content = '<p> 您好，您申请加入【'.$name['data']['name'].'】的申请已被拒绝。</p>';
        }
        $data = [
            'type' => 1,
            'class' => 3,
            'to_user_id' => $user_id['data']['user_id'],
            'content' => $content,
        ];
        $res = $nnm->add($data);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '审核成功');
    }

    /**
     * 经纪公司
     * 管理
     * 需合作艺人
     * 合作记录
     */
    public function coop_log()
    {
        $result = $this->validate($this->param,'app\common\validate\My.coop_log');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        if($this->param['type'] != 0){
            $where[] = ['b.status', '=', $this->param['type']];
        }
        $where[] = ['b.b_id', '=', $this->param['id']];

        $field = 'u.nickname, u.only, u.phone, b.create_time, b.status';

        $res = db('BrokerageAgencyMember')
        ->alias('b')
        ->join('User u', 'b.user_id = u.id')
        ->where($where)
        ->field($field)
        ->page($this->param['page'], $this->param['limit'])
        ->select();

        $arr = [1=>'已同意', 2=>'未同意'];
        foreach($res as &$v)
        {
            $v['create_time'] = date('Y-m-d H:i:s', $v['create_time']);
            $v['status'] = $arr[$v['status']];
        }

        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 经纪公司
     * 管理
     * 查看密码修改,内部艺人加入时输入的密码
     */
    public function pwd_edit()
    {
        $result = $this->validate($this->param,'app\common\validate\My.pwd_edit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
     
        $bam = new BrokerageAgency();
        $res = $bam->edit($this->param);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '修改成功');
    }

    /**
     * 经纪公司
     * 管理
     * 查看商务合作记录
     */
    public function business_cooperation()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id_limit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $bcm = new BusinessCooperation();

        $where[] = ['obj_type', '=', 3];
        $where[] = ['obj_id', '=', $this->param['id']];

        $field = 'company, name, phone, create_time, content';
        $order = 'id desc';
        $res = $bcm->getList($this->param['page'], $this->param['limit'], $where, $field, $order);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '修改成功');
    }

    /**
     * 经纪公司
     * 查看
     */
    public function company_see()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $bam = new BrokerageAgency();
        $res = $bam->getInfo(['id'=>$this->param['id']], 'id, name, logo, only, people, phone, introduce, notice, other_logo, other');
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result($res['data'], 200, '获取数据成功');
    }

    /**
     * 经纪公司
     * 查看
     * 艺人申请加入
     */
    public function apply_join()
    {
        $result = $this->validate($this->param,'app\common\validate\My.apply_join');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        // 提交了申请后,同一家不能再次提交申请
        // 可重复提交申请,但1个经纪公司统一后,其它公司就不行了

        // 先检测艺人信息正确否, 获取用户id
        $um = new User();
        $where = [ 
            ['nickname', '=', $this->param['name']],
            ['only', '=', $this->param['only']],
            ['is_star', 'in', '1,2']
        ];
        $id = $um->getInfo($where, 'id');
        if($id['code'] != 200){
            $this->result([], 400, '艺人信息错误');
        }

        // 不能重复申请
        $where = [ 
            ['b_id', '=', $this->param['id']], 
            ['user_id', '=', $id['data']['id']], 
            ['type', '=', $this->param['type']],
            ['status', '=', '0']
        ];
        $bamm = new BrokerageAgencyMember();
        $res = $bamm->getInfo($where);
        if($res['code'] == 200){
            $this->result([], 400, '已提交,审核中');
        }

        // 内部艺人.检测密码
        if($this->param['type'] == 1){
            $bam = new BrokerageAgency();
            $pwd = $bam->getVal(['id'=>$this->param['id']], 'pwd');
            if($pwd['data'] != $this->param['pwd']){
                $this->result([], 400, '密码错误');
            }
        }

        // type  1=>内部艺人  2=>外部艺人
        $res = $bamm->add(['b_id'=>$this->param['id'], 'user_id'=>$id['data']['id'], 'type'=>$this->param['type']]);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '提交成功');
    }

    /**
     * 经纪公司
     * 查看
     * 艺人申请加入
     */
    public function padding() 
    {
        if(!empty($this->param['name'])){
            $where[] = ['u.nickname', '=', $this->param['name']];
        }

        if(!empty($this->param['only'])){
            $where[] = ['u.only', '=', $this->param['only']];
        }
        
        $where[] = ['u.is_star', 'in', '1,2'];
        $field = 'u.id, u.nickname, u.head, u.only, u.phone, s.backup_number, s.fans_number, s.content';
        $res = db('User')
        ->alias('u')
        ->join('Star s', 'u.id = s.user_id')
        ->where($where)
        ->field($field)
        ->find();

        if(empty($res)){
            $this->result([], 200, '获取数据成功');
        }

        // 加域名
        if(strpos($res['head'],'uploads') === false){
            $res['head'] = config('app.qiniu.cdnUrl').$res['head'];
        }else{
            $res['head'] =  config('app.url').$res['head'];
        }

        // 随从
        $sem = new StarEntourage();
        $res['list'] = $sem->getList(0, 0, ['user_id'=>$res['id']], 'job, name, head')['data'];

        $this->result($res, 200, '获取数据成功');
    }

    /**
     * 我要出名 is_star == 0
     */
    public function apply_famous()
    {
        $result = $this->validate($this->param,'app\common\validate\My.apply_famous');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        // 读取登录手机号,加到明星预留手机号里
        $um = new User();
        $phone = $um->getInfo(['id'=>$this->user_id], 'phone');
        if($phone['code'] != 200){
            $this->result([], 400, $phone['msg']);
        }


        // 艺人信息添加
        $sm = new Star();
        $this->param['user_id'] = $this->user_id;
        $this->param['phone'] = $phone['data']['phone'];
        $res = $sm->add($this->param);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        // 艺人随从添加
        $arr = json_decode($this->param['ent'], true);
        foreach($arr as &$v)
        {
            $v['user_id'] = $this->user_id;
        }
        $sem = new StarEntourage();
        $res = $sem->addAll($arr);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '提交成功');
    }

    /**
     * 我要出名 is_star == 1
     * 回显信息
     */
    public function star_info()
    {
        $result = $this->validate($this->param,'app\common\validate\My.id');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $um = new User();
        $res_a = $um->getInfo(['id'=>$this->param['id']], 'id, nickname, head, only');
        if($res_a['code'] != 200){
            $this->result([], 400, $res_a['msg']);
        }
    
        // 经纪公司联系方式
        $phone = db('BrokerageAgencyMember')
        ->alias('bm')
        ->join('BrokerageAgency b', 'bm.b_id = b.id')
        ->where(['bm.user_id'=>$this->user_id, 'bm.status'=>1])
        ->field('b.phone')
        ->find();

        $sm = new Star();
        $res_b = $sm->getInfo(['user_id'=>$this->param['id']], 'phone, title, content, notice, other_logo, other, fans_number ');
        if($res_b['code'] != 200){
            $this->result([], 400, $res_b['msg']);
        }
        
        // 随从
        $sem = new StarEntourage();
        $list = $sem->getList(0, 0, ['user_id'=>$this->param['id']], 'id, job, name, head')['data'];

        $data = [
            'id' => $res_a['data']['id'],
            'name' => $res_a['data']['nickname'],
            'head' => $res_a['data']['head'],
            'only' => $res_a['data']['only'],
            'fans_number' => $res_b['data']['fans_number'],
            'phone_a' => $res_b['data']['phone'],                   // 明星预留手机号
            'phone_b' => isset($phone) ? $phone['phone'] : "未加入经纪公司",  // 经纪公司手机号
            'title'   => $res_b['data']['title'],
            'content' => $res_b['data']['content'],
            'notice' => $res_b['data']['notice'],
            'other_logo' => $res_b['data']['other_logo'],
            'other' => $res_b['data']['other'],
            'list' => $list,
        ];

        $this->result($data, 200, '获取数据成功');
    }

    /**
     * 我要出名 is_star == 1
     * 认证
     */
    public function attestation()
    {
        $result = $this->validate($this->param,'app\common\validate\My.attestation');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }
        $this->param['user_id'] = $this->user_id;
        $sam = new StartAuth();

        // 不许重复提交认证,除非
        $is_res = $sam->getInfo(['user_id'=>$this->user_id], 'id, status');
        if($is_res['code'] == 200){

            // 为2时,审核失败,可重复提交
            if($is_res['data']['status'] == 2){

                $this->param['id'] = $is_res['data']['id'];
                $this->param['status'] = 0;
                $sam->edit($this->param);

                $this->result([], 200, '等待审核中');
            }
            // status 0=>待审 1=>成功 2=>失败
            $msg = $is_res['data']['status'] == 0 ? '已提交,等待审核中' : '不能重复提交';
            $this->result([], 400, $msg);
        }

        // 添加.
        $res = $sam->add($this->param);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '等待审核中');
    }

    /**
     * 我要出名 修改
     */
    public function star_info_edit()
    {
        $result = $this->validate($this->param,'app\common\validate\My.star_info_edit');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        $sem = new StarEntourage();
        $arr = json_decode($this->param['ent'], true);
        foreach($arr as &$v)
        {
            unset($v['job']);
        }
        $res = $sem->saveAll($arr);

        $sm = new Star();
        unset($this->param['token']);
        unset($this->param['ent']);
        $res = $sm->editWhere($this->param, ['user_id'=>$this->user_id]);
        if($res['code'] != 200){
            $this->result([], 400, $res['msg']);
        }

        $this->result([], 200, '修改成功');

    }

    /**
     * 我要出名
     * 合作记录
     */
    public function star_coop_log()
    {
        $result = $this->validate($this->param,'app\common\validate\My.star_coop_log');
        if(true !== $result){
            // 验证失败 输出错误信息
            $this->result([], 400, $result);
        }

        if($this->param['status'] == 1){

            if(!empty($this->param['type'])){
                $where[] = ['bm.status', '=', $this->param['type']];
            }
            $where[] = ['bm.user_id', '=', $this->user_id];
            $field = 'b.name, b.only, b.phone, bm.create_time, bm.status';

            $res['data'] = db('BrokerageAgencyMember')
            ->alias('bm')
            ->join('BrokerageAgency b', 'bm.b_id = b.id')
            ->where($where)
            ->field($field)
            ->page($this->param['page'], $this->param['limit'])
            ->select();

            $arr = [1=>'已同意', 2=>'未同意'];
            foreach($res['data'] as &$v)
            {
                $v['create_time'] = date('Y-m-d H:i:s', $v['create_time']);
                $v['status'] = $arr[$v['status']];
            }
        }else{
            $bcm = new BusinessCooperation();
            $where = []; 
            $where[] = ['obj_type', '=', 1];
            $where[] = ['obj_id', '=', $this->user_id];
            $field = 'company, name, phone, content, create_time';
            $res = $bcm->getList($this->param['page'], $this->param['limit'], $where, $field);
            if($res['code'] != 200){
                $this->result([], 400, $res['msg']);
            }

        }

        $this->result($res['data'], 200, '获取数据成功');

    }


    /**
     * 推荐工具
     * 邀请分享,平台分享
     */
    public function platform_sharing()
    {
        
        $uqm = new UserQrcode();
        $where = ['obj_type'=>2, 'user_id'=>$this->user_id];
        $field = 'img';
        $res = $uqm->getInfo($where, $field);
        if($res['code'] != 200){

            // PTTGC+随机码+日期+用户id+随机数
            $url = config('app.url').'capi/Home/judge_code?type=PTTGC&number='.mt_rand(100, 999).'&date='.time().'&user_id='.$this->user_id.'&number_z='.mt_rand(100, 999);
            $img = scerweima($url, 2);
            $where['img'] = $img;
            $uqm->add($where);

            $this->result(config('app.url').$img, 200, '获取数据成功');

        }else{
            $this->result($res['data']['img'], 200, '获取数据成功');
        }
    }

}
