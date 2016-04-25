//
//  ViewController.m
//  LGW_NavCustomFreeZoomIcon
//
//  Created by Lilong on 16/4/25.
//  Copyright © 2016年 第七代目. All rights reserved.
//
//  导航条自由缩放头像效果
#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIImageView *headerImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setTitleView{
    UIView *titleView = [[UIView alloc] init];
    self.navigationItem.titleView = titleView;
    
    self.headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seven"]];
    self.headerImageView.layer.cornerRadius = 37;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.frame = CGRectMake(0, 0, 70, 70);
    self.headerImageView.center = CGPointMake(titleView.center.x, 0); //保证用户头像水平居中
    [titleView addSubview:self.headerImageView];
}
#pragma mark - TableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 33;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 55;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    CGFloat scale = 1.0;
    // 放大
    if (offsetY < 0) {
        // 允许下拉放大的最大距离为300
        // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
        // 这个值可以自由调整
        scale = MIN(1.5, 1 - offsetY / 300);
    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为300
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 300);
    }
    
    self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 保证缩放后y坐标不变
    CGRect frame = self.headerImageView.frame;
    frame.origin.y = -self.headerImageView.layer.cornerRadius / 2;
    self.headerImageView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
