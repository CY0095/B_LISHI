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
#define EquipDetailRequest_Url(ID) [NSString stringWithFormat:@"http://api.lis99.com/zhuangbei/items/0/20?cate_id=%@",ID]
//运动装备界面
#define sportClothDetailRequest_Url(ID) [NSString stringWithFormat:@"http://api.lis99.com/zhuangbei/items/0/20?sport_id=%@",ID]
//福利社衣服的界面
#define flClothClothDetailRequest_Url @"http://api.lis99.com/v3/club/lineactivedetail"


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


#endif /* RequestUrls_h */
