//
//  MessageFrame.m
//
//
//  Created by ling Kangli on 15-8-3.
//  Copyright (c) 2015年 Fengdu. All rights reserved.
//


#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message{
    
    _message = message;
    
    // 0、获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
    if (_showTime){
        
        CGFloat timeY = kMargin;
//        CGSize timeSize = [_message.time sizeWithAttributes:@{UIFontDescriptorSizeAttribute: @"16"}];
        CGSize timeSize = [_message.time sizeWithFont:kTimeFont];
        NSLog(@"----%@", NSStringFromCGSize(timeSize));
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + kTimeMarginW, timeSize.height + kTimeMarginH);
    }
    // 2、计算头像位置
    CGFloat iconX = kMargin;
    // 2.1 如果是自己发得，头像在右边
    if (_message.type == MessageTypeMe) {
        iconX = screenW - kMargin - kIconWH;
    }

    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);

    // 3、计算内容位置
    
    switch (message.showType) {
        case MessageShowTypeText:{
            
            CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
            CGFloat contentY = iconY;
            CGSize contentSize = [_message.content sizeWithFont:kContentFont constrainedToSize:CGSizeMake(kContentW, CGFLOAT_MAX)];
            
            if (_message.type == MessageTypeMe) {
                contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
            }
            
            _contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
//            _networkConnectRect = CGRectMake(_contentF.origin.x-40, _contentF.origin.y, 50, 50);
            _networkConnectRect = CGRectMake(_contentF.origin.x-40, _contentF.origin.y, 50, 50);//连网测试

        }
            
            break;
        case MessageShowTypeImg:
        case MessageShowTypeData:{
            CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
            CGFloat contentY = iconY;
            CGSize contentSize = CGSizeMake(kImgMarginW, kImgMarginH);
            
            if (_message.type == MessageTypeMe) {
                contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
            }
            
            _contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
            _networkConnectRect = CGRectMake(_contentF.origin.x-40, _contentF.origin.y, 25, 25);//连网测试
        }
            break;
        case MessageShowTypeImgVoice:
        case MessageShowTypeImgVoiceByUIIMG:
        case MessageShowTypeMultChatImg:{
            CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
            CGFloat contentY = iconY;
            CGSize contentSize =  CGSizeMake(kImgMarginW, kImgMarginH);
            
            if (_message.type == MessageTypeMe) {
                contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
            }
            
            _contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
            
            _voiceF = CGRectMake(_contentF.origin.x-50, _contentF.origin.y, 50, 50);
            _networkConnectRect = CGRectMake(_voiceF.origin.x-40, _voiceF.origin.y, 50, 50);//连网测试
        }
            break;
        default:
            break;
    }
    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}

@end
