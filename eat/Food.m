//
//  Food.m
//  eat
//
//  Created by gepeisong on 17/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Food.h"


@implementation Food
+ (NSString *)primaryKey {
    return @"ID";
}
-(void)save
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:self ];
    
    [realm commitWriteTransaction];
}
+(void)delFood:(int)Id
{
    Food *food=[Food searchFoodForId:Id];
    if(food==nil)return;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:food];
    [realm commitWriteTransaction];
}

+(Food*)searchFoodForId:(int) Id
{
    RLMResults<Food *> *food = [Food objectsWhere:[NSString stringWithFormat:@"ID=%d",Id]];
    if(food.count>0)
        return food[0];
    return nil;
}


+(int)searchFoodForFood:(NSString*) Name
{
    RLMResults<Food *> *food = [Food objectsWhere:[NSString stringWithFormat:@"Name='%@'",Name]];
    if(food.count>0)
    {
        Food *eat=food[0];
        return eat.ID;
    }
    return -1;
}

+(NSMutableArray *)GetAllFood
{
    RLMResults<Food *> *food = [[Food allObjects]sortedResultsUsingProperty:@"ID" ascending:YES];
    NSMutableArray *muArray=[[NSMutableArray alloc]init];
    for (Food *fo in food) {
        [muArray addObject:fo];
    }
    return muArray;
}

@end
