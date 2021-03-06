//
//  RequestUrls.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#ifndef RequestUrls_h
#define RequestUrls_h

//装备界面
#define ToolsRequest_Url @"http://api.lis99.com/zhuangbei/fenlei"
//福利积分兑换界面
#define ExchangeRequest_Url @"http://api.lis99.com/v3/zhuangbei"
//装备类型的详情界面
#define EquipDetailRequest_Url(number,ID) [NSString stringWithFormat:@"http://api.lis99.com/zhuangbei/items/%@/20?cate_id=%@",number,ID]
//运动装备界面
#define sportClothDetailRequest_Url(number,ID) [NSString stringWithFormat:@"http://api.lis99.com/zhuangbei/items/%@/20?sport_id=%@",number,ID]
//福利社衣服的界面
#define flClothClothDetailRequest_Url @"http://api.lis99.com/v3/club/lineactivedetail"
//更多免费界面
#define moreFreeClothDetailRequest_Url @"http://api.lis99.com/v5/club/tagTopic/0"
//购买运动装备的介绍界面
#define buySportClothDetailRequest_Url(ID) [NSString stringWithFormat:@"http://api.lis99.com/v3/zhuangbei/detail/%@",ID]
//商店界面
#define shopRequest_Url(number) [NSString stringWithFormat:@"http://api.lis99.com/v3/zhuangbei/brandshop/%@",number]
//商店详情界面
#define shopDetailRequest_Url @"http://api.lis99.com/shop/shopinfo"
//户外商店详情
#define outDoorShopRequest_Url @"http://api.lis99.com/shop/promotionShopList?latitude=40.02922418&longitude=116.33588774&offset=0&limit=20&cityid=1&shoptype=&sorttype="

// 登录
#define loginRequest_Url @"http://api.lis99.com/v2/user/loginMobile"
// 获取验证码
#define getCodeRequest_Url @"http://api.lis99.com/v2/user/sendCode"
// 注册
#define registerRequest_Url @"http://api.lis99.com/v2/user/regMobile"
// 上传头像接口
#define getHeadImgRequest_Url @"http://api.lis99.com/user/savePhoto"
// 修改昵称接口
#define changeNickNameRequest_Url @"http://api.lis99.com/v2/user/updNickname"


// 我的关注
#define myAttentionRequest_Url @"http://api.lis99.com/v3/user/myFollow/0"
// 推荐用户
#define recommendUserRequest_Url @"http://api.lis99.com/v3/user/recommendUser/0"
// 关注接口
#define attentionRequest_Url @"http://api.lis99.com/v3/user/addFollow"

// 用户详情接口
#define userDetailRequest_Url @"http://api.lis99.com/v5/user/uinfo/0"

// 发帖详情接口
#define topicsDetailRequest_Url @"http://api.lis99.com/v5/topics/detail"
// 评论接口
#define commentRequest_Url @"http://api.lis99.com/v5/topics/topicsReply"
// 帖子接口
#define postHeadRequest_Url(topic_id,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v3/club/topics/%@/%@",topic_id,user_id]

#define postReplyRequest_Url(topic_id,user_id,page) [NSString stringWithFormat:@"http://api.lis99.com/v2/club/replylist/%@/%@?page=%@",topic_id,user_id,page]
// 回复接口
#define replyRequest_Url @"http://api.lis99.com/v4/club/clubActivityTopic"
// 发帖接口
#define postMessageRequest_Url @"http://api.lis99.com/v5/topics/pubTopics"



// 社区列表URL
#define CommunityListRequest_Url(page) [NSString stringWithFormat:@"http://api.lis99.com/v4/club/omnibusList/%@/451316",page]
// 列表详情URL
#define CommunityListDetailRequest_Url @"http://api.lis99.com/v5/topics/detail"
// 社区徒步露营列表URL
#define CommunityLuyingListRequest_Url(page,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v5/club/topiclists/284/0?page=%@&user_id=%@",page,user_id]
// 板块介绍
#define LuyingHeaderViewRequest_Url @"http://api.lis99.com/v4/club/detail/284/451316"

// 社区户外摄影列表URL
#define CommunitySheyingListRequest_Url(page,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v5/club/topiclists/342/0?page=%@&user_id=%@",page,user_id]
// 板块介绍
#define SheyingHeaderViewRequest_Url @"http://api.lis99.com/v4/club/detail/342/451316"

// 社区极限攀登列表URL
#define CommunityPandengListRequest_Url(page,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v5/club/topiclists/349/0?page=%@&user_id=%@",page,user_id]
// 板块介绍
#define PandengHeaderViewRequest_Url @"http://api.lis99.com/v4/club/detail/349/451316"

// 社区装备控列表URL
#define CommunityZhuangbeikongListRequest_Url @"http://api.lis99.com/v5/club/topiclists/285/0?page=0&user_id=451316"
#define ZhuangbeikongHeaderViewRequest_Url @"http://api.lis99.com/v4/club/detail/285/451316"

// 社区户外范列表URL
#define CommunityHuwaifanListRequest_Url(page,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v5/club/topiclists/48/0?page=%@&user_id=%@",page,user_id]
#define HuwaifanHeaderViewRequest_Url @"http://api.lis99.com/v4/club/detail/48/451316"

#define CommunityAllListRequest_Url(club_id,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v5/club/topiclists/%@/0?page=0&user_id=%@",club_id,user_id]

#define CommunityAllListHeaderRequest_Url(club_id,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v4/club/detail/%@/%@",club_id,user_id]

#define CommunityAllCollectionViewRequest_Url @"http://api.lis99.com/v5/club/allclublist/"
// 俱乐部介绍
#define CommunityHeaderDetailRequest_Url(club_id,user_id) [NSString stringWithFormat:@"http://api.lis99.com/v4/club/detail/%@/%@",club_id,user_id]

// 活动页面url
#define ActivityRequest_Url(number,Latitude,Longitude)  [NSString stringWithFormat:@"http://api.lis99.com/v5/club/providActivity/%@?latitude=%@&longitude=%@",number,Latitude,Longitude]


// 活动详情页面url
#define ActivityDetailRequest_Url(activity_id,user_id)  [NSString stringWithFormat:@"https://apis.lis99.com/activity/detail?activity_id=%@&user_id=%@",activity_id,user_id]



#endif /* RequestUrls_h */
