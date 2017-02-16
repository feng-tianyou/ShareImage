//
//  UILabel+DAttributed.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UILabel+DAttributed.h"

@implementation UILabel (DAttributed)

/**
 *  获取带间距内容的文本size
 *
 *  @param content  全部内容
 *  @param font     字体
 *  @param maxWidth 最大宽大
 *
 *  @return 文本size
 */
+ (CGSize)getContentSizeForHasLineSpaceByContent:(NSString *)content
                                            font:(UIFont *)font
                                        maxWidth:(CGFloat)maxWidth{
    CGSize sizeContent = [content sizeWithFont:font maxWidth:maxWidth];
    NSString *strSize = @"擦";
    CGSize size = [strSize sizeWithFont:font maxWidth:maxWidth];
    if(size.height > 0){
        sizeContent.height += (sizeContent.height/size.height - 1) * 5 + 0.1;
    }
    return sizeContent;
}

/**
 *  获取带间距内容的文本size
 *
 *  @param content  全部内容
 *  @param font     字体
 *  @param maxWidth 最大宽度
 *  @param maxLineNum 最大行数
 *
 *  @return 文本size
 */
+ (CGSize)getContentSizeForHasLineSpaceByContent:(NSString *)content
                                            font:(UIFont *)font
                                        maxWidth:(CGFloat)maxWidth
                                      maxLineNum:(NSInteger)maxLineNum{
    CGSize sizeContent = [content sizeWithFont:font maxWidth:maxWidth];
    NSString *strSize = @"擦";
    CGSize size = [strSize sizeWithFont:font maxWidth:maxWidth];
    if(size.height > 0){
        CGFloat maxHeight = MAXFLOAT;
        if(maxLineNum > 0){
            maxHeight = size.height*maxLineNum + (maxLineNum - 1)*5 + 0.1;
        }
        sizeContent.height += (sizeContent.height/size.height - 1) * 5 + 0.1;
        if(sizeContent.height > maxHeight){
            sizeContent.height = maxHeight;
        }
    }
    return sizeContent;
}

- (void)addLineSpace{
    [self addLineSpace:5.0];
    [self setLineBreakMode:NSLineBreakByTruncatingTail];
    
}

- (void)addLineSpace:(float)space{
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:space];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
    
}

- (void)addKeyword:(NSString *)keyword
      keywordColor:(UIColor *)color{
    [self addKeyword:keyword keywordColor:color lineSpace:5.0];
}

- (void)addKeywords:(NSArray *)keywords
       keywordColor:(UIColor *)color{
    [self addKeywords:keywords keywordColor:color lineSpace:5.0];
}

/**
 *  获取带高亮内容的文本
 *
 *  @param keywords     高亮部分内容(数组)
 *  @param color        高亮的颜色
 *  @param keyWordFont  高亮内容字体
 *  @param lineSpace    行距
 *
 */
- (void)addKeyWords:(NSArray *)keywords
       keywordColor:(UIColor *)color
        keywordFont:(UIFont *)keyWordFont{
    [self addKeyWords:keywords keywordColor:color keywordFont:keyWordFont lineSpace:5.0];
}

- (void)addKeyword:(NSString *)keyword
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont{
    [self addKeyword:keyword keywordFont:keyWordFont contentFont:contentFont lineSpace:5.0];
}

- (void)addKeyWord1:(NSString *)keyword1
           keyWord2:(NSString *)keyword2
      keyword1Color:(UIColor *)keyword1Color
      keyword2Color:(UIColor *)keyword2Color{
    [self addKeyWord1:keyword1 keyWord2:keyword2 keyword1Color:keyword1Color keyword2Color:keyword2Color lineSpace:5.0];
}

- (void)addKeyWord:(NSString *)keyword
      keywordColor:(UIColor *)keywordColor
      contentColor:(UIColor *)contentColor
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont{
    [self addKeyWord:keyword keywordColor:keywordColor contentColor:contentColor keywordFont:keyWordFont contentFont:contentFont lineSpace:5.0];
}

- (void)addKeywordForNotSpace:(NSString *)keyword
                 keywordColor:(UIColor *)color{
    [self addKeyword:keyword keywordColor:color lineSpace:0.0];
}

- (void)addKeywordsForNotSpace:(NSArray *)keywords
                  keywordColor:(UIColor *)color{
    [self addKeywords:keywords keywordColor:color lineSpace:0.0];
}

- (void)addKeywordForNotSpace:(NSString *)keyword
                  keywordFont:(UIFont *)keyWordFont
                  contentFont:(UIFont *)contentFont{
    [self addKeyword:keyword keywordFont:keyWordFont contentFont:contentFont lineSpace:0.0];
}

- (void)addKeyWord1ForNotSpace:(NSString *)keyword1
                      keyWord2:(NSString *)keyword2
                 keyword1Color:(UIColor *)keyword1Color
                 keyword2Color:(UIColor *)keyword2Color{
    [self addKeyWord1:keyword1 keyWord2:keyword2 keyword1Color:keyword1Color keyword2Color:keyword2Color lineSpace:0.0];
}

- (void)addKeyWordForNotSpace:(NSString *)keyword
                 keywordColor:(UIColor *)keywordColor
                 contentColor:(UIColor *)contentColor
                  keywordFont:(UIFont *)keyWordFont
                  contentFont:(UIFont *)contentFont{
    [self addKeyWord:keyword keywordColor:keywordColor contentColor:contentColor keywordFont:keyWordFont contentFont:contentFont lineSpace:0.0];
}




- (void)addKeyword:(NSString *)keyword
      keywordColor:(UIColor *)color
         lineSpace:(float)lineSpace{
    if(self.text.length == 0){
        DLog(@"请先设置label的text属性");
        return;
    }
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = [self.text rangeOfString:keyword];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)color range:range];
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:lineSpace];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
}

- (void)addKeywords:(NSArray *)keywords
       keywordColor:(UIColor *)color
          lineSpace:(float)lineSpace{
    if(self.text.length == 0){
        DLog(@"请先设置label的text属性");
        return;
    }
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    for (NSString *keyword in keywords.objectEnumerator) {
        NSRange range = [self.text rangeOfString:keyword];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)color range:range];
    }
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:lineSpace];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
}


/**
 *  获取带高亮内容的文本
 *
 *  @param keywords     高亮部分内容(数组)
 *  @param color        高亮的颜色
 *  @param keyWordFont  高亮内容字体
 *  @param lineSpace    行距
 *
 */
- (void)addKeyWords:(NSArray *)keywords
       keywordColor:(UIColor *)color
        keywordFont:(UIFont *)keyWordFont
          lineSpace:(float)lineSpace{
    if(self.text.length == 0){
        DLog(@"请先设置label的text属性");
        return;
    }
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    for (NSString *keyword in keywords.objectEnumerator) {
        NSRange range = [self.text rangeOfString:keyword];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)color range:range];
        [attributeStr addAttribute:NSFontAttributeName value:keyWordFont range:range];
    }
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:lineSpace];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
}



- (void)addKeyword:(NSString *)keyword
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont
         lineSpace:(float)lineSpace{
    if(self.text.length == 0){
        DLog(@"请先设置label的text属性");
        return;
    }
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = [self.text rangeOfString:keyword];
    
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:lineSpace];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, self.text.length)];
    [attributeStr addAttribute:NSFontAttributeName value:(id)contentFont range:NSMakeRange(0, self.text.length)];
    [attributeStr addAttribute:NSFontAttributeName value:(id)keyWordFont range:range];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
}

- (void)addKeyWord1:(NSString *)keyword1
           keyWord2:(NSString *)keyword2
      keyword1Color:(UIColor *)keyword1Color
      keyword2Color:(UIColor *)keyword2Color
          lineSpace:(float)lineSpace{
    NSString *content = self.text;
    if(content.length == 0){
        DLog(@"请先设置label的text属性");
        return;
    }
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange range1 = [content rangeOfString:keyword1];
    NSRange range2 = [content rangeOfString:keyword2];
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:lineSpace];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, content.length)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)keyword1Color range:range1];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)keyword2Color range:range2];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
}

- (void)addKeyWord:(NSString *)keyword
      keywordColor:(UIColor *)keywordColor
      contentColor:(UIColor *)contentColor
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont
         lineSpace:(float)lineSpace{
    NSString *content = self.text;
    if(content.length == 0){
        DLog(@"请先设置label的text属性");
        return;
    }
    NSTextAlignment textAlign = self.textAlignment;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange range = [content rangeOfString:keyword];
    
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:lineSpace];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, content.length)];
    [attributeStr addAttribute:NSFontAttributeName value:(id)contentFont range:NSMakeRange(0, content.length)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)contentColor range:NSMakeRange(0, content.length)];
    
    [attributeStr addAttribute:NSForegroundColorAttributeName value:(id)keywordColor range:range];
    [attributeStr addAttribute:NSFontAttributeName value:(id)keyWordFont range:range];
    [self setAttributedText:attributeStr];
    [self setTextAlignment:textAlign];
}

@end
