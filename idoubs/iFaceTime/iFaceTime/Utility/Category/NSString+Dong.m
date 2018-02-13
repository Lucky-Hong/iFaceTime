//
//  NSString+Dong.m
//  SevenColorMovies
//
//  Created by yesdgq on 16/8/5.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import "NSString+Dong.h"

@implementation NSString (Dong)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (CGFloat)heightForLineWithFont:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.height;
}

- (NSMutableAttributedString *)attributedString
{
    return [[NSMutableAttributedString alloc] initWithString:self];
}

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font
{
    NSDictionary *attrs = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [[NSMutableAttributedString alloc] initWithString:self attributes:attrs];
}

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 0.001f;
    
    style.lineSpacing = lineSpacing;
    [string addAttribute:NSFontAttributeName value:font range:range];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:range];
    return string;
}

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    //    style.alignment = NSTextAlignmentJustified;
    //    style.firstLineHeadIndent = 0.001f;
    style.lineSpacing = lineSpacing;
    [string addAttribute:NSFontAttributeName value:font range:range];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:range];
    return string;
}


- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing characterSpacing:(CGFloat)spacing firstLineSpacing:(CGFloat)firstSpacing {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = firstSpacing;
    style.alignment = NSTextAlignmentJustified;
    style.lineSpacing = lineSpacing;
    [string addAttribute:NSFontAttributeName value:font range:range];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:range];
    [string addAttribute:NSKernAttributeName value:@(spacing) range:range];
    return string;
}



- (BOOL)isBlank
{
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]] || [self stringByTrimmingWhitespaceAndNewline].length == 0) {
        return YES;
    }
    return NO;
}

- (instancetype)stringByTrimmingWhitespaceAndNewline {
    return [[[self stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\r" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (instancetype)stringByTrimmingNewline {
    return [[self stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}

- (instancetype)stringByTrimmingString:(NSString *)string {
    return [self stringByReplacingOccurrencesOfString:string withString:@""];
}

- (instancetype)stringByTrimmingHyphen{
    return [self stringByTrimmingString:@"-"];
}

- (instancetype)stringByTrimmingBlank{
    return [self stringByTrimmingString:@" "];
}

// 去除冒号
- (instancetype)stringByTrimmingColon {
    return [self stringByTrimmingString:@":"];
}

// 去掉等号
- (instancetype)stringByTrimmingEqualMark
{
    return [self stringByTrimmingString:@"="];
}

- (instancetype)absoluteDateString {
    return [[[self stringByTrimmingString:@"-"] stringByTrimmingString:@":"] stringByTrimmingString:@" "];
}

- (BOOL)isOnlyWhitespace
{
    return ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0);
}

+ (instancetype)stringFromIntValue:(int)intValue
{
    return [NSString stringWithFormat:@"%d", intValue];
}

+ (instancetype)stringFromIntegerValue:(NSInteger)integerValue
{
    return [NSString stringWithFormat:@"%ld", (long)integerValue];
}

+ (instancetype)stringFromUIntegerValue:(NSUInteger)uIntValue
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)uIntValue];
}

+ (instancetype)stringFromBOOLValue:(BOOL)boolValue
{
    return boolValue ? @"YES" : @"NO";
}

+ (instancetype)stringFromNowDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [fmt stringFromDate:date];
}

+ (instancetype)absoluteStringFromNowDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHHmmss";
    return [fmt stringFromDate:date];
}

- (BOOL)isMoreThanOneLineConstraintToWidth:(CGFloat)width withFont:(UIFont *)font {
    return [self sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width > width;
}

- (instancetype)stringByBase64Encoding {
    NSData *encodeData = [self dataUsingEncoding:NSASCIIStringEncoding];
    return [encodeData base64EncodedStringWithOptions:0];
}

- (instancetype)stringByBase64Decoding {
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
}

- (double)timestampWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:dateFormat];
    NSDate *date = [fmt dateFromString:self];
    return [date timeIntervalSince1970];
}


//*****************************☝️☝️☝️☝️☝️☝️字符合法校验☝️☝️☝️☝️☝️☝️☝️☝️*******************

# if 0
// 校验工号 不能包含小写字母
+ (BOOL)verifyJobNumber:(NSString *)input
{
    NSString *regex = @"[^abcdefghijklmnopqrstuvwxyz]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入工号！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"工号不能包含小写字母！"];
        return NO;
    }
    return YES;
}

// 校验中文姓名 汉子 + .
+ (BOOL)verifyCNName:(NSString *)input
{
    NSString *regex = @"^[\u4e00-\u9fa5.]{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入姓名！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"姓名格式不正确！"];
        return NO;
    }
    return YES;
}

// 目标安装地址地址 不包含 ^`~!@%#$^&*? 字符
+ (BOOL)verifyNewAddress:(NSString *)input
{
    NSString *regex = @"[^`~!@%#$^&*?]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入目标安装地址！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"目标安装地址格式不正确！"];
        return NO;
    }
    return YES;
}

// 校验详细地址 不包含 ^`~!@%#$^&*? 字符
+ (BOOL)verifyDetailAddress:(NSString *)input
{
    NSString *regex = @"[^`~!@%#$^&*?]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入详细地址！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"详细地址格式不正确！"];
        return NO;
    }
    return YES;
}

// 校验地址 不包含 ^`~!@%#$^&*? 字符
+ (BOOL)verifyAddress:(NSString *)input
{
    NSString *regex = @"[^`~!@%#$^&*?]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入地址！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"地址格式不正确！"];
        return NO;
    }
    return YES;
}

// 校验手机号
+ (BOOL)verifyMobilePhone:(NSString *)input
{
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入手机号！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"手机号格式不正确！"];
        return NO;
    }
    return YES;
}

// 座机校验
+ (BOOL)verifyTelephone:(NSString *)input
{
    NSString *regex = @"^([0-9]{3,4}(-)?)?[0-9]{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        return YES;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"电话号码格式不正确！"];
        return NO;
    }
    return YES;
}

// 邮编校验
+ (BOOL)verifyZipCode:(NSString *)input
{
    NSString *regex = @"[^0]\\d{5}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL verificationResult = [predicate evaluateWithObject:input];
    if (input.length == 0) {
        [MBProgressHUD showError:@"请输入邮编！"];
        return NO;
    } else if (input.length > 0 && !verificationResult){
        [MBProgressHUD showError:@"邮编格式不正确！"];
        return NO;
    }
    return YES;
}

# endif


- (NSInteger)integerValue {
    NSMutableString *str1 = [NSMutableString stringWithString:self];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == 'A' || c == 'B'|| c == 'C'|| c == 'D' || c == 'E'|| c == 'F'|| c == 'G' || c == 'H'|| c == 'I'|| c == 'J' || c == 'K'|| c == 'L'|| c == 'M' || c == 'N'|| c == 'O'|| c == 'P' || c == 'Q'|| c == 'R'|| c == 'S' || c == 'T'|| c == 'U'|| c == 'V' || c == 'W'|| c == 'X'|| c == 'Y' || c == 'Z') { // 此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    
    return (NSInteger)[newstr intValue];
}

@end
