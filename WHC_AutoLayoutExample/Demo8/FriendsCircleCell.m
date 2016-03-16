//
//  FriendsCircleCell.m
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

#import "FriendsCircleCell.h"
#import "WHC_AutoLayoutExample-Swift.h"

@implementation AnswerMenuView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.whc_Edge = UIEdgeInsetsZero;
        self.whc_Orientation = Horizontal;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        _supperButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _answerButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_supperButton setTitle:@"赞" forState:UIControlStateNormal];
        [_supperButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _supperButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_answerButton setTitle:@"评论" forState:UIControlStateNormal];
        [_answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _answerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_supperButton];
        [self addSubview:_answerButton];
        [self whc_StartLayout];
        [_supperButton addTarget:self action:@selector(clickSupperButton:) forControlEvents:UIControlEventTouchUpInside];
        [_answerButton addTarget:self action:@selector(clickAnswerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)clickSupperButton:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _supperButton.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        _supperButton.transform = CGAffineTransformIdentity;
        if (_delegate && [_delegate respondsToSelector:@selector(answerMenuView:isClickSupper:)]) {
            [_delegate answerMenuView:self isClickSupper:YES];
        }
    }];
}

- (void)clickAnswerButton:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(answerMenuView:isClickSupper:)]) {
        [_delegate answerMenuView:self isClickSupper:NO];
    }
}

@end

@interface FriendsCircleCell ()<AnswerMenuViewDelegate> {

    UILabel                * _userNameLabel;
    UILabel                * _contentLabel;
    UILabel                * _supportUserLabel;
    UILabel                * _timeLabel;
    UIButton               * _answerButton;
    UIView                 * _supportView;
    
    UIImageView            * _userImageView;
    UIImageView            * _supportImageView;
    UIImageView            * _upArrowImageView;
    
    NSMutableArray         * _commentLabelArray;
    NSMutableArray         * _imageViewArray;
    
    WHC_StackView          * _imageStackView;
    WHC_StackView          * _commentStackView;
    AnswerMenuView         * _menuView;
    
    FriendModel            * _model;
}

@end

@implementation FriendsCircleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect cellFrame = self.contentView.frame;
        cellFrame.size.width = [UIScreen mainScreen].bounds.size.width;
        self.contentView.frame = cellFrame;
        _commentLabelArray = [NSMutableArray array];
        _imageViewArray = [NSMutableArray array];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initLayout];
    }
    return self;
}

- (void)createLayoutView {
    _userImageView = [UIImageView new];
    _userNameLabel = [UILabel new];
    _contentLabel = [UILabel new];
    _timeLabel = [UILabel new];
    _answerButton = [UIButton new];
    _imageStackView = [WHC_StackView new];
    _upArrowImageView = [UIImageView new];
    _commentStackView = [WHC_StackView new];
    _supportView = [UIView new];
    _supportImageView = [UIImageView new];
    _supportUserLabel = [UILabel new];
    
    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_answerButton];
    [self.contentView addSubview:_imageStackView];
    [self.contentView addSubview:_upArrowImageView];
    [self.contentView addSubview:_commentStackView];
    [self.contentView addSubview:_supportView];
    
    [_supportView addSubview:_supportImageView];
    [_supportView addSubview:_supportUserLabel];
    
    [_supportImageView whc_LeftSpace:5];
    [_supportImageView whc_CenterY:0];
    [_supportImageView whc_Size:CGSizeMake(15, 15)];
    
    [_supportUserLabel whc_LeftSpace:5 toView:_supportImageView];
    [_supportUserLabel whc_TopSpace:0];
    [_supportUserLabel whc_RightSpace:0];
    [_supportUserLabel whc_BottomSpace:0];
    
    [_supportView whc_BottomLine:1 lineColor:[UIColor colorWithWhite:0.8 alpha:1]];
    
    [_answerButton addTarget:self action:@selector(clickAnswerButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    _userNameLabel.textColor = [UIColor colorWithRed:37.0 / 255 green:75.0 / 255 blue:131.0 / 255 alpha:1];
    _supportImageView.image = [UIImage imageNamed:@"like"];
    [_answerButton setBackgroundImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    _upArrowImageView.image = [UIImage imageNamed:@"LikeCmtBg"];
    _commentStackView.backgroundColor = [UIColor colorWithRed:240.0 / 255 green:240.0 / 255 blue:240.0 / 255 alpha:1.0];
    _supportView.backgroundColor = _commentStackView.backgroundColor;
    _timeLabel.text = @"1小时前";
    _supportUserLabel.backgroundColor = _commentStackView.backgroundColor;
    _supportUserLabel.text = @"吴海超(WHC)";
    _supportUserLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.backgroundColor = [UIColor whiteColor];
}

- (void)initLayout {
    [self createLayoutView];
    
    /// 使用先进的WHC_AutoLayoutKit进行自动布局
    [_userImageView whc_Frame:WHCRectMake(10, 15, 40, 40)];
    
    [_userNameLabel whc_TopSpaceEqualView:_userImageView];
    [_userNameLabel whc_LeftSpace:10 toView:_userImageView];
    [_userNameLabel whc_WidthAuto];
    [_userNameLabel whc_Height:20];
    
    [_contentLabel whc_LeftSpaceEqualView:_userNameLabel];
    [_contentLabel whc_TopSpace:5 toView:_userNameLabel];
    [_contentLabel whc_RightSpace:10];
    [_contentLabel whc_HeightAuto];
    
    [_imageStackView whc_TopSpace:5 toView:_contentLabel];
    [_imageStackView whc_LeftSpaceEqualView:_contentLabel];
    [_imageStackView whc_RightSpace:10];
    [_imageStackView whc_AutoHeight];
    
    /// 配置图片展示容器
    _imageStackView.whc_Column = 3;               // 最大3列
    _imageStackView.whc_Edge = UIEdgeInsetsZero;  // 内边距为0
    _imageStackView.whc_Space = 4;                // 图片之间的空隙为4
    _imageStackView.whc_Orientation = All;        // 横竖混合布局
    _imageStackView.whc_HeightWidthRatio = 4 / 3; // 图片高宽比
    
    [_timeLabel whc_TopSpace:10 toView:_imageStackView];
    [_timeLabel whc_LeftSpaceEqualView:_imageStackView];
    [_timeLabel whc_Size:CGSizeMake(100, 20)];
    
    [_answerButton whc_TopSpaceEqualView:_timeLabel];
    [_answerButton whc_TrailingSpace:10];
    [_answerButton whc_Size:CGSizeMake(30, 25)];
    
    [_upArrowImageView whc_TopSpace:5 toView:_timeLabel];
    [_upArrowImageView whc_LeftSpaceEqualView:_timeLabel];
    [_upArrowImageView whc_Size:CGSizeMake(60, 20)];
    
    [_supportView whc_TopSpace:10 toView:_timeLabel];
    [_supportView whc_LeftSpaceEqualView:_timeLabel];
    [_supportView whc_RightSpace:10];
    [_supportView whc_Height:21];
    
    [_commentStackView whc_TopSpace:0 toView:_supportView];
    [_commentStackView whc_LeftSpaceEqualView:_timeLabel];
    [_commentStackView whc_RightSpace:10];
    [_commentStackView whc_AutoHeight];
    
    /// 配置评论展示容器
    _commentStackView.whc_Edge = UIEdgeInsetsMake(5, 5, 5, 5);  // 内边距为5
    _commentStackView.whc_Space = 10;                           // 评论之间的空隙为10
    _commentStackView.whc_Orientation = Vertical;               // 垂直布局
    
    /// 设置cell底部间隙
    self.whc_CellBottomView = _commentStackView;
    self.whc_CellBottomOffset = 10;
    [self whc_BottomLine:1 lineColor:[UIColor colorWithWhite:0.8 alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setComment:(UILabel *)label answer:(Answer *)answer userName:(NSString *)userName {
    NSString * text = nil;
    if (answer.isReply) {
        text = [NSString stringWithFormat:@"%@回复%@: %@",answer.name,userName,answer.content];
    }else {
        text = [NSString stringWithFormat:@"%@: %@",answer.name,answer.content];
    }
    label.text = text;
    NSMutableAttributedString * textAttr = [[NSMutableAttributedString alloc] initWithString:text];
    if (answer.isReply) {
        [textAttr addAttribute:NSForegroundColorAttributeName value:_userNameLabel.textColor range:[text rangeOfString:answer.name]];
        [textAttr addAttribute:NSForegroundColorAttributeName value:_userNameLabel.textColor range:[text rangeOfString:userName]];
    }else {
        [textAttr addAttribute:NSForegroundColorAttributeName value:_userNameLabel.textColor range:[text rangeOfString:answer.name]];
    }
    label.attributedText = textAttr;
}

/// 评论StackView和图片StackView视图复用处理
- (void)resetstackViewWithIsComment:(BOOL)isComment model:(FriendModel *)friendModel {
    NSInteger oldCount = isComment ? _commentStackView.whc_SubViewCount : _imageStackView.whc_SubViewCount;
    NSInteger countDiff = isComment ? friendModel.answerArray.count - oldCount : friendModel.imageArray.count - oldCount;
    if (countDiff < 0) {
        NSArray * subViewArray = isComment ? _commentStackView.subviews : _imageStackView.subviews;
        NSArray * removeCommentViewArray = [subViewArray subarrayWithRange:NSMakeRange(oldCount + countDiff, -countDiff)];
        for (UIView * view in removeCommentViewArray) {
            [view removeFromSuperview];
        }
        oldCount = isComment ? _commentStackView.whc_SubViewCount : _imageStackView.whc_SubViewCount;
    }
    countDiff = MAX(0, countDiff);
    for (int i = 0; i < oldCount; i++) {
        if (isComment) {
            Answer * answer = friendModel.answerArray[i];
            UILabel * commentLabel = _commentStackView.subviews[i];
            [self setComment:commentLabel answer:answer userName:friendModel.userName];
        }else {
            UIImageView * imageView = _imageStackView.subviews[i];
            if (_model.imageArray.count > i &&
                [_model.imageArray[i] isEqualToString:friendModel.imageArray[i]]){}else {
                imageView.image = [UIImage imageNamed:friendModel.imageArray[i]];
            }
        }
    }
    for(int i = 0; i < countDiff; i++) {
        BOOL isNew = NO;
        if (isComment) {
            UILabel * commentLabel = (_commentLabelArray.count > oldCount + i ? _commentLabelArray[oldCount + i] : nil);
            if (commentLabel == nil) {
                isNew = YES;
                commentLabel = [UILabel new];
                commentLabel.backgroundColor = _commentStackView.backgroundColor;
                commentLabel.numberOfLines = 0;
                commentLabel.font = [UIFont systemFontOfSize:14];
            }
            Answer * answer = friendModel.answerArray[oldCount + i];
            [self setComment:commentLabel answer:answer userName:friendModel.userName];
            if (isNew) {
                [_commentLabelArray addObject:commentLabel];
            }
            [_commentStackView addSubview:commentLabel];
        }else {
            UIImageView * imageView = (_imageViewArray.count > oldCount + i ? _imageViewArray[oldCount + i] : nil);
            if (imageView == nil) {
                isNew = YES;
                imageView = [UIImageView new];
                imageView.userInteractionEnabled = YES;
            }
            imageView.tag = oldCount + i;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageGesture:)];
            [imageView addGestureRecognizer:tapGesture];
            imageView.image = [UIImage imageNamed:friendModel.imageArray[i + oldCount]];
            if(isNew) {
                [_imageViewArray addObject:imageView];
            }
            [_imageStackView addSubview:imageView];
        }
    }
    isComment ? [_commentStackView whc_StartLayout] : [_imageStackView whc_StartLayout];
}

- (void)setFriendModel:(FriendModel *)friendModel {
    if (!_model) {
        if (![_model.userImage isEqualToString:friendModel.userImage]) {
            _userImageView.image = [UIImage imageNamed:friendModel.userImage];
        }
    }
    _userNameLabel.text = friendModel.userName;
    _contentLabel.text = friendModel.content;
    if (friendModel.isSupper) {
        _supportView.hidden = YES;
        [_commentStackView whc_TopSpace:10 toView:_timeLabel];
    }else {
        _supportView.hidden = NO;
        [_commentStackView whc_TopSpace:0 toView:_supportView];
    }
    if (friendModel.imageArray.count == 1) {
        _imageStackView.whc_Column = 2;
    }else {
        _imageStackView.whc_Column = 3;
    }
    [self resetstackViewWithIsComment:NO model:friendModel];
    [self resetstackViewWithIsComment:YES model:friendModel];
    if (friendModel.answerArray.count == 0) {
        _upArrowImageView.hidden = YES;
    }else {
        _upArrowImageView.hidden = NO;
    }
    _model = nil;
    _model = friendModel;
}

#pragma mark - buttonAction -

- (void)tapImageGesture:(UITapGestureRecognizer *)tapGesture {
    NSInteger column = 3;
    if (_model.imageArray.count == 1) {
        column = 2;
    }
    [WHC_ImageDisplayView show:_model.imageArray index:tapGesture.view.tag item:tapGesture.view column:column];
}

- (void)clickAnswerButton:(UIButton *)sender {
    if (!_menuView) {
        _menuView = [AnswerMenuView new];
        _menuView.delegate = self;
    }
    [_menuView whc_Width:0];
    [self.contentView addSubview:_menuView];
    [_menuView whc_TrailingSpace:2 toView:_answerButton];
    [_menuView whc_CenterY:0 toView:_answerButton];
    [_menuView layoutIfNeeded];
    [_menuView whc_Size:CGSizeMake(150, 40)];
    [UIView animateWithDuration:0.3 animations:^{
        [_menuView layoutIfNeeded];
        [_menuView whc_StartLayout];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - AnswerMenuViewDelegate -

- (void)answerMenuView:(AnswerMenuView *)menuView isClickSupper:(BOOL)isSupper {
    [menuView removeFromSuperview];
    if (isSupper) {
        _model.isSupper = !_model.isSupper;
        if (_delegate && [_delegate respondsToSelector:@selector(friendsCircleSupperCell:)]) {
            [_delegate friendsCircleSupperCell:self];
        }
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(friendsCircleCell:clickRow:lastCommentLabel:)]) {
            UIView * answerLabel = [_commentStackView.subviews lastObject];
            if (_commentStackView.subviews.count == 0) {
                answerLabel = _commentStackView;
            }
            [_delegate friendsCircleCell:self clickRow:_row lastCommentLabel:answerLabel];
        }
    }
}

@end
