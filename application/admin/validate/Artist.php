<?php

namespace app\common\validate;

use think\Validate;

class Artist extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
        'page'    => 'require|number',
        'limit'   => 'require|number',
        'status'  => 'require|between:1,7',
        'id'      => 'require|number',
        'a_id'    => 'require|number',
        'user_id' => 'require|number',
        'type'    => 'require|number',
        'fans_number' => 'require|number',
        'position'=>'require',
        'start_time' =>'require',
        'end_time'=>'require',
        'price'   => 'require|number',
        'company' => 'require',
        'name' => 'require',
        'phone' => 'mobile|require',
        'content' => 'require',
        'logo' => 'require',
        'introduce' => 'require',
        'notice' => 'require',
        'other' => 'require',
        'other_logo' => 'require',
        
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'page.require'    => '页数必填',
        'page.number'     => '页数必须整数',
        'limit.require'   => '条数必填',
        'limit.number'    => '条数必须整数',
        'status.require'  => '参数status必填',
        'status.between'  => '参数status不在给定值内',
        'id.require'      => '缺少参数id',
        'id.number'       => '参数id必须数字',
        'a_id.require'    => '缺少参数a_id',
        'a_id.number'     => '参数a_id必须数字',
        'user_id.require' => '用户id必填',
        'user_id.number'  => '用户id必须数字',
        'type.require'    => '缺少参数type',
        'type.number'     => '参数type必须数字',
        'fans_number.require' => '粉丝数量必填',
        'fans_number.number' => '粉丝数量必须为数字',
        'position.require'=> '广告位置必填',
        'start_time.require' => '投放时间必填',
        'end_time.require'=> '结束时间必填',
        'price.require'   => '广告价格必填',
        'price.number'    => '广告价格必须数字',
        'company.require' => '公司名称必填',
        'name.require'    => '联系人必填',
        'phone.require'   => '手机号必填',
        'phone.mobile'    => '手机号格式错误',
        'content.require' => '合作内容必填',
        'logo.require'    => '图片必填',
        'introduce.require' => '介绍必填',
        'notice.require' => '公告必填',
        'other.require' => '平台内容必填',
        'other_logo.require' => '平台标志必填',
        
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'star_sort' => ['page', 'limit', 'type'],
        'star_info' => ['id'],
        'star_list' => ['page', 'limit'],
        'star_search' => ['page', 'limit'],
        'star_program' => ['page', 'limit', 'id'],
        'star_program_info' => ['id'],
        'add_backup' => ['user_id', 'name', 'logo','phone', 'introduce', 'notice', 'other', 'other_logo'],
        'star_entourage' => ['id'],
        'star_introduce_info' => ['id'],
        'banner' => ['id'],
        'add_banner' => ['id', 'price', 'position', 'type'],
        'banner_list' => ['id', 'type', 'status'],
        'banner_info' => ['id'],
        'banner_choice' => ['id', 'type'],
        'backup_sort' => ['page', 'limit', 'id', 'type'],
        'star_backup' => ['page', 'limit', 'id'],
        'star_backup_info' => ['id'],
        'backup_number' => ['page', 'limit', 'id'],
        'cooperation' => ['id', 'a_id'],
        'banner_choice_log' => ['page', 'limit', 'id', 'type', 'start_time', 'end_time', 'status'],
        'banner_screen' => ['page', 'limit', 'price', 'position', 'start_time', 'type'],
        'business_cooperation' => ['company', 'name', 'phone', 'content', 'type', 'id'],
        'company' => ['user_id'],
        'company_artist' => ['page', 'limit', 'id', 'type'],
        'backup_number_info' => ['id'],
        'share_winner'  => ['id'],
        'join_backup'   => ['id'],
        'union_list'    => ['page', 'limti', 'id'],
        'vote'          => ['user_id', 'id'],
        'vote_list'     => ['id'],
        'vote_log'      => ['start_time', 'user_id'],
    ];
}
