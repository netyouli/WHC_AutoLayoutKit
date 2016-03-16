//
//  FriendModel.h
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/10.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*************************************************************
 *                                                           *
 *  qq:712641411                                             *
 *  开发作者: 吴海超(WHC)                                      *
 *  iOS技术交流群:302157745                                    *
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit     *
 *                                                           *
 *************************************************************/

#import <Foundation/Foundation.h>

@interface Answer : NSObject
@property (nonatomic ,copy) NSString * name;
@property (nonatomic ,copy) NSString * content;
@property (nonatomic ,assign)BOOL isReply;
@end

@interface FriendModel : NSObject
@property (nonatomic ,copy) NSString * content;
@property (nonatomic ,copy) NSString * userImage;
@property (nonatomic ,copy) NSString * userName;
@property (nonatomic ,copy) NSArray  * imageArray;
@property (nonatomic ,strong) NSMutableArray  * answerArray;
@property (nonatomic ,assign) BOOL  isSupper;
@end
