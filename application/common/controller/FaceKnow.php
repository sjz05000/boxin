<?php

namespace app\common\controller;

use think\Controller;

// 人脸识别
class FaceKnow extends Controller
{
    private $accessToken;
    private $position = "./accessToken/faceknowAccessToken.json";	//用于存放accessToken的地址，记得提前生成对应文件夹和文件，或者通过命令生成
    private $apiKey = '你申请的apikey';
    private $secretKey = '你申请的secrekey';


    public function __construct()
    {
        self::getAccessToken();
    }


    /**
     * 整合发送url
     * @param $url  请求的url
     * @param $post_data    发送的数据
     * @return mixed    返回的结果
     */
    private function HttpUrl($url, $post_data)
    {
    //      $post_data = ($post_data);
        $o = "";
        foreach ($post_data as $k => $v) {
            $o .= "$k=" . urlencode($v) . "&";
        }
        $post_data = substr($o, 0, -1);

        $res = $this->httpCurl($url, $post_data);

        return $res;
    }

    private function getAccessToken()
    {

        $data = json_decode(file_get_contents($this->position), true);

        //没有或过期的话就新增或修改
        if (!$data || !isset($data['expires_time']) || $data['expires_time'] <= time()) {
            $this->prepareToken();
        } else {
            $this->accessToken = $data['access_token'];
        }


    }

    /**
     * 生成数据插入文件
     */
    private function prepareToken()
    {
        //获取Token
        $url = 'https://aip.baidubce.com/oauth/2.0/token';
        $post_data['grant_type'] = 'client_credentials';
        $post_data['client_id'] = $this->apiKey;
        $post_data['client_secret'] = $this->secretKey;

        $data = self::HttpUrl($url, $post_data);
        $data = json_decode($data, true);
        $data['expires_time'] = $data['expires_in'] + time();

        $fp = fopen($this->position, "w");
        fwrite($fp, json_encode($data));
        fclose($fp);
    }

    /**
     * 人脸注册
     */
    public function faceRegister($userId, $image, $userInfo = '用户登录', $groupId = 'wyc_bishe')
    {
        $url = 'https://aip.baidubce.com/rest/2.0/face/v3/faceset/user/add?access_token=' . $this->accessToken;

        $image = config('systemConfig.img_domain') . $image;
        $data = [
            "image" => $image,
            "image_type" => "URL",
            "group_id" => $groupId,
            "user_id" => $userId,
            "user_info" => $userInfo
        ];

        $res = $this->httpCurl($url, $data);


        $res = json_decode($res, true);

        return $res;


    }


    /**
     * 删除用户
     */
    public function faceDelete($userId, $groupId, $faceToken)
    {

        $url = 'https://aip.baidubce.com/rest/2.0/face/v3/faceset/user/delete?access_token=' . $this->accessToken;

        $data = [
            "user_id" => $userId,
            "group_id" => $groupId,
            "face_token" => $faceToken
        ];

        $res = $this->httpCurl($url, $data);

        $res = json_decode($res, true);

        return $res;

    }


    /**
     * 用户查询
     */
    public function faceFind($image, $groupIdList = 'wyc_bishe')
    {
        $url = 'https://aip.baidubce.com/rest/2.0/face/v3/search?access_token=' . $this->accessToken;

        $image = config('systemConfig.img_domain') . $image;
        $data = [
            "image" => $image,
            "image_type" => "URL",
            "group_id_list" => $groupIdList,
        ];

        $res = json_decode($this->httpCurl($url, $data), true);


        return $res;
    }


    /**
     * curl请求访问
     * @param $url string 地址
     * @param $data string post数据
     * @return mixed string 返回结果
     */
    private function httpCurl($url, $data = '')
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_REFERER, $url);
        curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Linux; Android 5.0; SM-N9100 Build/LRX21V) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/37.0.0.0 Mobile Safari/537.36 V1_AND_SQ_5.3.1_196_YYB_D QQ/5.3.1.2335 NetType/WIFI");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        if ($data != '') {
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec($curl);
        return $result;
    }
}


