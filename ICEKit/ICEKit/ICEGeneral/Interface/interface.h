//
//  interface.h
//
//  Created by 陈冰 on 15/5/7.
//  Copyright (c) 2015年 Glacier. All rights reserved.
//

#ifndef __interface_h
#define __interface_h

/**
 *  @author 陈冰, 15-05-07 (创建)
 *
 *  此文件里的方法是 系统接口
 *
 *  @since 1.0
 */

// 服务器域名
//正式服务器
//#define ApiSystemDomain @"www.online.com"
//测试服务器
//#define ApiSystemDomain @"http://423823.ichengyun.net/hpjobweb/index.php/app"
//#define ApiSystemImage @"http://423823.ichengyun.net/hpjobweb/"
#define ApiSystemDomain @"http://121.40.251.178/index.php/app"
#define ApiSystemImage @"http://121.40.251.178/"

#define ApiUpload       ApiSystemDomain@"/index/upload"
// -------职位------------------------------------------------------------------------------------------
// 得到职位柄
#define ApiGetLinkage       ApiSystemDomain@"/search/getLinkage"
// 职位列表
#define ApiRecruit          ApiSystemDomain@"/search/recruit"
// 职位/公司详情
#define ApiRecruitInfo      ApiSystemDomain@"/search/recruitInfo"
// 收藏职位
#define ApiFavorite         ApiSystemDomain@"/profile/favorite"
// 取消收藏
#define ApiDelFav           ApiSystemDomain@"/profile/delFav"
// 得到收藏职位
#define ApiViewFav          ApiSystemDomain@"/profile/viewFav"
// 公司详情信息 【暂不用】
//#define ApiGetCompanyInfo   ApiSystemDomain@"/company/getCompanyInfo"
// 得到该公司其他职位
#define ApiGetOthers        ApiSystemDomain@"/search/getOthers"
// 投递简历
#define ApiDeliver          ApiSystemDomain@"/profile/deliver"
// 投递记录
#define ApiPostLog          ApiSystemDomain@"/profile/postLog"
// 热门职位分类
#define ApiHot              ApiSystemDomain@"/search/hot"
// 校园招聘
#define ApiSchoolJob        ApiSystemDomain@"/search/schoolJob"
// 兼职工作
#define ApiPartTimeJob      ApiSystemDomain@"/search/partTimeJob"
// 入职返现
#define ApiReturnMoney      ApiSystemDomain@"/search/returnMoney"
// 包吃包住
#define ApiEatJob           ApiSystemDomain@"/search/eatJob"
// 附近工作
#define ApiNearJobs         ApiSystemDomain@"/search/nearJobs"
// 放心企业
#define ApiRelievedCompany  ApiSystemDomain@"/search/relievedCompany"
// 高薪职位
#define ApiHighSalary       ApiSystemDomain@"/search/highSalary"
// 搜索职位
#define ApiSearchIndex      ApiSystemDomain@"/search/index"
// 全部福利列表
#define ApiAllWelfares      ApiSystemDomain@"/search/allWelfares"

// ---------登录------------------------------------------------------------------------------------------
// 登录
#define ApiLogin            ApiSystemDomain@"/auth/login"
// 注册
#define ApiRegister         ApiSystemDomain@"/auth/register"
// 忘记密码
#define ApiFindPassword     ApiSystemDomain@"/auth/find_password"
// 注销登陆
#define ApiLogout           ApiSystemDomain@"/auth/logout"
// 第三方登录 [暂时未用上]
//#define ApiAuthLogin        ApiSystemDomain@"/auth/authLogin"
// 添加经纬度
#define ApiUpdateLocation   ApiSystemDomain@"/auth/get_address"
// 发送验证码
#define ApiSms              ApiSystemDomain@"/auth/sms"

// -------简历--------------------------------------------------------------------------------------
// 创建简历
#define ApiCreateNewRes     ApiSystemDomain@"/profile/createNewRes"
// 修改简历
#define ApiUpdateResume     ApiSystemDomain@"/profile/updateResume"
// 简历详情 ［安卓使用了］
#define ApiResumeView       ApiSystemDomain@"/profile/resumeView"
// 工作经验列表
#define ApiJobExpList       ApiSystemDomain@"/profile/jobExpList"
// 修改工作经验
#define ApiUpdateWorkExp    ApiSystemDomain@"/profile/updateWorkExp"
// 删除工作经验
#define ApiDeleteResumeJob  ApiSystemDomain@"/profile/deleteResumeJob"
// 我的简历（简历列表）
#define ApiResumeList       ApiSystemDomain@"/profile/resume"
// 刷新简历
#define ApiRefreshResume    ApiSystemDomain@"/profile/refreshResume"
// 设为默认简历
#define ApiSetDefaultResu   ApiSystemDomain@"/profile/defaultRes"
// 删除简历
#define ApiDelResume        ApiSystemDomain@"/profile/del"
// 谁看过我
#define ApiLookThrough      ApiSystemDomain@"/profile/lookThrough"
// 简历预览（获取填写的简历数据）
#define ApiPreviewResume    ApiSystemDomain@"/profile/preview"
// 三天内自动投递 [暂时未用上]
#define ApiAutoDelivery     ApiSystemDomain@"/profile/auto_delivery"

// -------个人中心------------------------------------------------------------------------------------------
// 修改密码
#define ApiPassword         ApiSystemDomain@"/auth/password"
// 修改个人信息
#define ApiEditPerson       ApiSystemDomain@"/auth/editPerson"
// 获取个人信息
#define ApiGetPerson        ApiSystemDomain@"/auth/getPerson"
// 签到
#define ApiSign             ApiSystemDomain@"/auth/sign"
// 是否签到
#define ApiIsSign           ApiSystemDomain@"/auth/is_sign"
// 签到记录
#define ApiSignRecord       ApiSystemDomain@"/auth/sign_record"
// 求职意向
#define ApiJobInvension     ApiSystemDomain@"/profile/jobInvension"
// 获取用户求职意向
#define ApiUserInvension    ApiSystemDomain@"/profile/user_intension"
// 积分记录
#define ApiPointRecord      ApiSystemDomain@"/auth/point_record"
// 获取用户积分
#define ApiGetPoint         ApiSystemDomain@"/auth/getPoint"
// APP首页轮播广告
#define ApiAds              ApiSystemDomain@"/auth/ads"
// 是否审核（用户佣金）
#define ApiIdentificationv  ApiSystemDomain@"/auth/identification"
// 认证（用户佣金）
#define ApiApprove          ApiSystemDomain@"/auth/approve"
// 佣金金额
#define ApiUserCommission   ApiSystemDomain@"/auth/user_commission"
// 获取银行信息
#define ApiBankInfo         ApiSystemDomain@"/auth/bank_info"
// 佣金提现
#define ApiWithdraw         ApiSystemDomain@"/auth/withdraw"
// 佣金明细
#define ApiCommissionLog    ApiSystemDomain@"/auth/commission_log"
// 工资查询
#define ApiSalaryQuery      ApiSystemDomain@"/auth/salary_query"
// 系统消息
#define ApiGetMessages      ApiSystemDomain@"/profile/getMessages"

//-------发现---------------------------------------------------------
// 创建群
#define ApiCreateGroup      ApiSystemDomain@"/profile/createGroup"
// 附近的群
#define ApiNearGroups       ApiSystemDomain@"/profile/nearGroups"
// 附近的人
#define ApiNearPeople       ApiSystemDomain@"/profile/nearPeople"
// 获取群信息
#define ApiGetGroupInfo     ApiSystemDomain@"/profile/getGroupInfo"
// 获得推荐群
#define ApiGetRecommendGroups ApiSystemDomain@"/profile/getRecommendGroups"
// 发布动态
#define ApiReleaseDynamic   ApiSystemDomain@"/profile/releaseDynamic"
// 评论动态
#define ApiCommentSns       ApiSystemDomain@"/profile/commentSns"
// 点赞动态
#define ApiZanSns           ApiSystemDomain@"/profile/zanSns"
// 生活服务
#define ApiLifeService      ApiSystemDomain@"/search/lifeService"
// 删除群
#define ApiDelGroup         ApiSystemDomain@"/profile/delGroup"
// 分享得积分
#define ApiShareIntegral    ApiSystemDomain@"/profile/delGroup"
// 加好友得积分
#define ApiAddFriendsIntegral ApiSystemDomain@"/profile/addFriendsIntegral"

//-------网页---------------------------------------------------------
// 工资列表
#define ApiSalaryList       ApiSystemDomain@"/auth/salaryList/uid/"
// 位置转码获取详细地址
#define ApiAnalysisLocation ApiSystemDomain@"/index/getLocation"
// 分享
#define ApiShare            ApiSystemDomain@"/auth/share/from/9"
// 广场
#define ApiSns              ApiSystemDomain@"/index/sns"
// 抽奖活动
#define ApiAward            ApiSystemDomain@"/index/award"
// 限时抢购
#define ApiMoneyGoods       ApiSystemDomain@"/goods/moneyGoods/uid/"
// 积分兑换
#define ApiIntegralGoods    ApiSystemDomain@"/goods/integralGoods/uid/"
// 简历预览
#define ApiViewResume       ApiSystemDomain@"/auth/viewResume/resume_id/%@"
// 获取群组头像
#define ApiTeamAvatar       ApiSystemDomain@"/index/teamAvatar/group/"
#endif

