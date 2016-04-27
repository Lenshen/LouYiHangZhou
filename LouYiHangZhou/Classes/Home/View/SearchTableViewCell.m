//
//  SearchTableViewCell.m
//  进口零食
//
//  Created by 远深 on 16/4/27.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "SearchCollectionViewCell.h"
@interface SearchTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>{

}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation SearchTableViewCell


- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self setCollectionView];
    }
    return self;
}
-(void)setCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
    
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
