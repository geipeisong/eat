//
//  Food.h
//  eat
//
//  Created by gepeisong on 17/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Food: RLMObject

@property(nonatomic,assign) int ID;//食物编号
@property(nonatomic,strong)NSString* Name;//食物的名称

-(void)save;
+(void)delFood:(int)Id;
+(Food*)searchFoodForId:(int) Id;
+(NSMutableArray *)GetAllFood;
+(int)searchFoodForFood:(NSString*) Name;
@end
