<?php

namespace app\common\validate;

use think\Validate;

class My extends Validate
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
        'status'  => 'require|in:1,2',
        'id'      => 'require|number',
        'del_id'  => 'require',
        'user_id' => 'require|number',
        'type'    => 'require|number',
        'img'     => 'require',
        'phone'     => 'require',
        'introduce' => 'require',
        'notice'    => 'require',
        'other'     => 'require',
        'other_logo' => 'require',
        'phone'    => 'require|mobile',
        'logo'     => 'require',
        'pwd'      => 'require',
        'name'     => 'require',
        'only'     => 'require',
        'title'    => 'require',
        'content'  => 'require',
        'ent'      => 'require',
        'education' => 'require',
        'work' => 'require',
        'identity_card_a' => 'require',
        'identity_card_b' => 'require',
        'resident_name'   => 'require',
        'identity_card'   => 'require|idCard',
        'identity_card_term' => 'require',
        'identity_card_validity' => 'require',
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
        'status.in'       => '参数status不在给定值内',
        'id.require'      => '缺少参数id',
        'id.number'       => '参数id必须数字',
        'del_id.require'  => '缺少参数id',
        'user_id.require' => '用户id必填',
        'user_id.number'  => '用户id必须数字',
        'type.require'    => '缺少参数type',
        'type.number'     => '参数type必须数字',
        'img.require'     => '图片必传',
        'phone.require'   => '电话必传',
        'phone.mobile'    => '手机号格式错误',
        'introduce.require' => '介绍必传',
        'notice.require'  => '公告必传',
        'other.require'   => '其它平台信息必传',
        'other_logo.require' => '其它平台标志必传',
        'logo.require'    => '图片必传',
        'pwd.require'     => '密码必填',
        'name.require'    => '艺人名称必填',
        'only.require'    => '艺人ID必填',
        'title.require'   => '标题必填',
        'content.require' => '介绍必填',
        'ent.require'     => '随从必填',
        'education.require'  => '学历图必填',
        'work.require'       => '工作证明图必填',
        'identity_card_a.require' => '身份证-正面必填',
        'identity_card_b.require' => '身份证-反面必填',
        'resident_name.require'   => '入住人必填',
        'identity_card.require'   => '身份证必填',
        'identity_card.idCard'   => '身份证格式错误',
        'identity_card_term.require' => '身份证期限必填',
        'identity_card_validity.require' => '身份证日期必填',
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        // 共用
        'id'       => ['id'],
        'limit'    => ['page', 'limit'],
        'id_limit' => ['id', 'page', 'limit'],

        // 单用
        'collect_list'  => ['page', 'limit', 'type'],
        'footprint_del' => ['del_id'],
        'card_list'     => ['type'] ,
        'version_update'=> ['del_id', 'type', 'status'],
        'backup_edit'   => ['id', 'phone', 'introduce', 'notice', 'other', 'other_logo'],
        'company_edit'  => ['id', 'introduce', 'notice', 'other', 'other_logo'],
        'is_yes_no'     => ['id', 'type'],
        'coop_log'      => ['page', 'limit', 'id', 'type'],
        'pwd_edit'      => ['id', 'pwd'],
        'apply_join'    => ['id', 'name', 'only', 'type'],
        'apply_famous'  => ['title', 'content', 'notice', 'other_logo', 'other', 'ent'],
        'attestation'   => ['education', 'work', 'identity_card_a', 'identity_card_b', 'resident_name', 'identity_card', 'identity_card_term', 'identity_card_validity'],
        'star_info_edit'=> ['title', 'content', 'notice', 'other_logo', 'other', 'ent', 'phone'],
        'star_coop_log' => ['status', 'type'],
    ];
}
