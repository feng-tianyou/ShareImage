//
//  UILabel+DAttributed.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DAttributed)

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
                                        maxWidth:(CGFloat)maxWidth;

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
                                      maxLineNum:(NSInteger)maxLineNum;


//为文本添加5的行距
- (void)addLineSpace;

/**
 *  //为文本添加行距
 *
 *
 *  @param space 行距
 */
- (void)addLineSpace:(float)space;

/**
 *  添加5的行距带高亮内容的文本
 *
 *  @param keyword 关键字部分
 *  @param color   高亮的颜色
 *
 */
- (void)addKeyword:(NSString *)keyword
      keywordColor:(UIColor *)color;

/**
 *  添加5的行距带高亮内容的文本
 *
 *  @param keywords 关键字部分
 *  @param color   高亮的颜色
 *
 */
- (void)addKeywords:(NSArray *)keywords
       keywordColor:(UIColor *)color;

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
        keywordFont:(UIFont *)keyWordFont;


/**
 *  添加5的行距带不同字体内容的文本
 *
 *
 *  @param keyword     关键字部分
 *  @param keyWordFont 关键字字体
 *  @param contentFont 其它文本字体
 */
- (void)addKeyword:(NSString *)keyword
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont;

/**
 *  添加5的行距带双高亮内容的文本
 *
 *
 *  @param keyword1      关键字1部分
 *  @param keyword2      关键字2部分
 *  @param keyword1Color 关键字1部分颜色
 *  @param keyword2Color 关键字2部分颜色
 */
- (void)addKeyWord1:(NSString *)keyword1
           keyWord2:(NSString *)keyword2
      keyword1Color:(UIColor *)keyword1Color
      keyword2Color:(UIColor *)keyword2Color;

/**
 *  添加5的行距带高亮不同字体内容的文本
 *
 *
 *  @param keyword      关键字
 *  @param keywordColor 关键字部分颜色
 *  @param contentColor 其它颜色
 *  @param keyWordFont  关键字字体
 *  @param contentFont  其它字体
 */
- (void)addKeyWord:(NSString *)keyword
      keywordColor:(UIColor *)keywordColor
      contentColor:(UIColor *)contentColor
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont;

/**
 *  不带行距带高亮内容的文本
 *
 *  @param keyword 关键字部分
 *  @param color   高亮的颜色
 *
 */
- (void)addKeywordForNotSpace:(NSString *)keyword
                 keywordColor:(UIColor *)color;

/**
 *  不带行距带高亮内容的文本
 *
 *  @param keywords 关键字部分
 *  @param color   高亮的颜色
 *
 */
- (void)addKeywordsForNotSpace:(NSArray *)keywords
                  keywordColor:(UIColor *)color;

/**
 *  不带行距带不同字体内容的文本
 *
 *
 *  @param keyword     关键字部分
 *  @param keyWordFont 关键字字体
 *  @param contentFont 其它文本字体
 */
- (void)addKeywordForNotSpace:(NSString *)keyword
                  keywordFont:(UIFont *)keyWordFont
                  contentFont:(UIFont *)contentFont;

/**
 *  不带行距带双高亮内容的文本
 *
 *
 *  @param keyword1      关键字1部分
 *  @param keyword2      关键字2部分
 *  @param keyword1Color 关键字1部分颜色
 *  @param keyword2Color 关键字2部分颜色
 */
- (void)addKeyWord1ForNotSpace:(NSString *)keyword1
                      keyWord2:(NSString *)keyword2
                 keyword1Color:(UIColor *)keyword1Color
                 keyword2Color:(UIColor *)keyword2Color;

/**
 *  不带行距带高亮不同字体内容的文本
 *
 *
 *  @param keyword      关键字
 *  @param keywordColor 关键字部分颜色
 *  @param contentColor 其它颜色
 *  @param keyWordFont  关键字字体
 *  @param contentFont  其它字体
 */
- (void)addKeyWordForNotSpace:(NSString *)keyword
                 keywordColor:(UIColor *)keywordColor
                 contentColor:(UIColor *)contentColor
                  keywordFont:(UIFont *)keyWordFont
                  contentFont:(UIFont *)contentFont;





- (void)addKeyword:(NSString *)keyword
      keywordColor:(UIColor *)color
         lineSpace:(float)lineSpace;

- (void)addKeywords:(NSArray *)keywords
       keywordColor:(UIColor *)color
          lineSpace:(float)lineSpace;

- (void)addKeyword:(NSString *)keyword
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont
         lineSpace:(float)lineSpace;

- (void)addKeyWords:(NSArray *)keywords
       keywordColor:(UIColor *)color
        keywordFont:(UIFont *)keyWordFont
          lineSpace:(float)lineSpace;

- (void)addKeyWord1:(NSString *)keyword1
           keyWord2:(NSString *)keyword2
      keyword1Color:(UIColor *)keyword1Color
      keyword2Color:(UIColor *)keyword2Color
          lineSpace:(float)lineSpace;

- (void)addKeyWord:(NSString *)keyword
      keywordColor:(UIColor *)keywordColor
      contentColor:(UIColor *)contentColor
       keywordFont:(UIFont *)keyWordFont
       contentFont:(UIFont *)contentFont
         lineSpace:(float)lineSpace;

@end
