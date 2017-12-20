//
//  TableCellView.m
//  eat
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TableCellView.h"
#import "Food.h"
@interface TableCellView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(strong,nonatomic)NSTimer *timer;
@property(strong,nonatomic)NSMutableArray *arr;

@end

@implementation TableCellView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEditing:YES];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
 
    
    
    CGFloat imageViewY=-64;
    CGFloat imageViewW=self.imageScroll.frame.size.width;
    CGFloat imageViewH=self.imageScroll.frame.size.height;
    for (int i=0; i<5; i++) {
        UIImageView *imageView=[UIImageView new];
        CGFloat imageViewX=i*imageViewW;
        imageView.frame=CGRectMake(imageViewX,imageViewY,imageViewW, imageViewH);
        
        
        [self.imageScroll insertSubview:imageView atIndex:0];
        NSString *imageName=[NSString stringWithFormat:@"%d.jpg",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
       
    
        
        
    }
    self.imageScroll.contentSize=CGSizeMake(imageViewW*5, 0);
    self.imageScroll.pagingEnabled=YES;
    self.pageControl.numberOfPages=5;
    self.imageScroll.delegate=self;
    [self addTimer];

   
    
}
-(void)nextImage
{
    NSInteger page=self.pageControl.currentPage;
    if (page==4) {
        page=0;
    }
    page++;
    [self.imageScroll setContentOffset:CGPointMake(self.imageScroll.frame.size.width*page,-64) animated:YES];
    
  
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset=scrollView.contentOffset;
    CGFloat offsetX=offset.x;
    CGFloat scrollW=scrollView.frame.size.width;
    int page=(offsetX+0.5*scrollW)/scrollW;
    self.pageControl.currentPage=page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer=nil;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
-(void)addTimer
{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer=timer;
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}











-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Food GetAllFood].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.arr = [Food GetAllFood];
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSLog(@"%ld",(long)indexPath.row);
    Food *eatFood=[Food GetAllFood][indexPath.row];
    cell.textLabel.text=eatFood.Name;
    CGFloat R  = (CGFloat) 255/255.0;
    CGFloat G = (CGFloat) 248/255.0;
    CGFloat B = (CGFloat) 220/255.0;
    CGFloat alpha = (CGFloat) 1.0;
    
    cell.backgroundColor= [ UIColor colorWithRed:R green:G  blue:B  alpha:alpha ];
    NSLog(@"%@",cell.textLabel.text);
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Food *eat=[Food GetAllFood][indexPath.row];
    int foodId=[Food searchFoodForFood:eat.Name];
    [Food delFood:foodId];
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSLog(@"%li",(long)indexPath.row);
        [_arr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObjects:indexPath, nil]withRowAnimation:UITableViewRowAnimationAutomatic];
    }


}


@end
