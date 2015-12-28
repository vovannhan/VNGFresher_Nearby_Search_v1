//
//  DetailViewController.m
//  VNGFresher_Nearby_Search
//
//  Created by NhanVo on 12/27/15.
//  Copyright © 2015 NhanVo. All rights reserved.
//

#import "DetailViewController.h"
#define API_KEY @"AIzaSyCy3zsPTh8UfIkq5gHYtPXGc0f-w7Nzfmc"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize json_detail,result_detail;

- (void)viewDidLoad {
    [super viewDidLoad];// Do any additional setup after loading the view.
    self.navigationItem.title = @"Thông tin chi tiết";
    self.photo_link = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=%@",self.photo_reference,API_KEY];
//    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.photo_link]];
//    self.img_Avar.image = [UIImage imageWithData:imageData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.photo_link]];
        
        if (data == nil) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.img_Avar.image = [UIImage imageWithData:data];
        });
    });
    
    NSURL *url_detail = [NSURL URLWithString:self.link_detail];
    NSData *data_detail = [NSData dataWithContentsOfURL:url_detail];
    json_detail = [NSJSONSerialization JSONObjectWithData:data_detail options:kNilOptions error:nil];
    result_detail = [json_detail objectForKey:@"result"];
    self.lbl_name.text = [result_detail objectForKey:@"name"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
