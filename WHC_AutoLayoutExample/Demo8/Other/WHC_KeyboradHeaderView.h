//
//  WHC_KeyboradHeaderView.h
//  CTBMobileBank
//
//  Created by 吴海超 on 15/5/27.
//
//

/*************************************************************
 *                                                           *
 *  qq:712641411                                             *
 *  开发作者: 吴海超(WHC)                                      *
 *  iOS技术交流群:302157745                                    *
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit     *
 *                                                           *
 *************************************************************/
#import <UIKit/UIKit.h>


@interface WHC_KeyboradHeaderView : UIView

+ (CGFloat)height;

+ (UIView *)monitorKeyboradShowAddHeaderViewObserver:(UIViewController*)sf
                                          leftAction:(SEL)leftAction
                                         rightAction:(SEL)rightAction
                                        cancelAction:(SEL)cancelAction;

+ (UIView *)monitorKeyboradShowAddHeaderViewObserver:(UIViewController*)sf
                                          leftAction:(SEL)leftAction
                                         rightAction:(SEL)rightAction
                                        cancelAction:(SEL)cancelAction
                                      showHeaderView:(BOOL)show;

+ (UIView *)monitorKeyboradShowAddHeaderViewObserver:(UIViewController*)sf
                                        cancelAction:(SEL)cancelAction;

+ (UIView *)monitorKeyboradShowAddHeaderViewObserver:(UIViewController*)sf
                                        cancelAction:(SEL)cancelAction
                                      showHeaderView:(BOOL)show;

+ (UIView *)monitorKeyboradShowAddHeaderView:(UIView *)headerView observer:(UIViewController *)sf;

- (UIButton *)createButton:(CGRect)frame txt:(NSString*)txt fontSize:(CGFloat)fontSize action:(SEL)action;

- (void)removeObserver;
@end
