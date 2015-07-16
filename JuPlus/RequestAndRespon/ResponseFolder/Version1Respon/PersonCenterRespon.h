//
//  PersonCenterRespon.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface PersonCenterRespon : JuPlusResponse
//头像
@property(nonatomic,strong)NSString *portrait;
//昵称
@property(nonatomic,strong)NSString *nickname;
//作品数
@property(nonatomic,strong)NSString *worksCount;
//购买
@property(nonatomic,strong)NSString *payCount;
//收藏
@property(nonatomic,strong)NSString *favourCount;

@end
