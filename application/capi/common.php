<?php

use think\Db;
/**
 * 添加足迹
 */
function add_footprint($type, $id, $user_id, $day)
{
    db('UserFootprint')->insert(['obj_type'=>$type, 'obj_id'=>$id, 'user_id'=>$user_id, 'day'=>$day]);
}