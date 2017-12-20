//
//  ViewController.m
//  eat
//
//  Created by iMac 16 on 16/7/28.
//  Copyright © 2016年 iMac 16. All rights reserved.
//

#import "ViewController.h"
#import "Food.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *showAll;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIImageView *stratStop;
@property (weak, nonatomic) IBOutlet UILabel *eat;
@property (weak, nonatomic) IBOutlet UIImageView *stop;
@property(strong,nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *add;
@property(strong,nonatomic)NSMutableArray *arr;
@property(copy,nonatomic)NSString *addText;

@property (strong, nonatomic) IBOutlet UIView *submitView;


- (IBAction)submit;

- (IBAction)Start;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.arr=[[NSMutableArray alloc]init];
    

    
    
   
    // Do any additional setup after loading the view, typically from a nib.
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边按钮" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//   
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右边按钮" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit {
   
     self.addText=self.add.text;
    if ([self.add.text isEqualToString:@""]) {
        
        UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:@"⚠警告！" message:@"不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定！" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertVc animated:NO completion:nil];

    }
    else
    {
  
        int eatId=[[Food GetAllFood] count];
        Food *eatFood=[[Food alloc]init];
        eatFood.Name=self.addText;
        eatFood.ID=eatId;
        [eatFood save];
        NSLog(@"%@",[Food GetAllFood]);
        
    }
 self.add.text=@"";

    
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 [self.submitView endEditing:YES];
}

- (IBAction)Start{
    
    if (self.stop.hidden==YES) {
        self.stratStop.hidden=YES;
        self.stop.hidden=NO;
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(next) userInfo:nil repeats:YES];
        self.timer=timer;
    }else
    {
        self.stratStop.hidden=NO;
        self.stop.hidden=YES;
        [self.timer invalidate];
    }
    
    
}
-(void)next
{
  
    //[self submit];
   
        
    [self arradd];
    if(_arr.count==0){
       // NSLog(@"空");
        self.eat.text=@"";
        self.image.image=[UIImage imageNamed:@"noData.png"];

    }else
    {
        self.image.image=[UIImage imageNamed:@"plate.jpg"];
//        NSLog(@"%lu",(unsigned long)self.arr.count);
        int a=arc4random()%(self.arr.count);
        Food *eat=self.arr[a];
        self.eat.text=eat.Name;
       
    
    }
    
    
}

-(void)arradd
{
    
    
   self.arr =[Food GetAllFood];
   NSLog(@"这是写入过数据的情况%@", self.arr);

   
    
}

@end
