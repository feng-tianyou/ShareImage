//
//  DPhotosModel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosModel.h"

@implementation DPhotosLinksModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"selfUrl":@"self"};
}

@end

@implementation DPhotosUrlsModel



@end


@implementation DPhotosModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"pid":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"user":[DUserModel class],
             @"urls":[DPhotosUrlsModel class],
             @"links":[DPhotosLinksModel class]};
}




/**
 {
 categories =     (
 );
 color = "#070706";
 "created_at" = "2017-02-17T16:05:27-05:00";
 "current_user_collections" =     (
 );
 downloads = 68;
 exif =     {
     aperture = "5.0";
     "exposure_time" = "1/4000";
     "focal_length" = 60;
     iso = 800;
     make = Nikon;
     model = "NIKON D800";
 };
 height = 6873;
 id = OSP3gMUYJVI;
 "liked_by_user" = 0;
 likes = 28;
 links =     {
     download = "http://unsplash.com/photos/OSP3gMUYJVI/download";
     "download_location" = "https://api.unsplash.com/photos/OSP3gMUYJVI/download";
     html = "http://unsplash.com/photos/OSP3gMUYJVI";
     self = "https://api.unsplash.com/photos/OSP3gMUYJVI";
 };
 location =     {
     city = Berlin;
     country = Germany;
     name = Berlin;
     position =         {
     latitude = "52.5200066";
     longitude = "13.404954";
 };
 title = "Berlin, Germany";
 };
 urls =     {
 full = "https://images.unsplash.com/photo-1487365468824-80e35a328956?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=c1632742118f202e34b21fc514c61018";
 raw = "https://images.unsplash.com/photo-1487365468824-80e35a328956";
 regular = "https://images.unsplash.com/photo-1487365468824-80e35a328956?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=fb36f73ccc34fa8c8770f6ab4f176429";
 small = "https://images.unsplash.com/photo-1487365468824-80e35a328956?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=68c13b345f4fa850ab46128ee20e9de8";
 thumb = "https://images.unsplash.com/photo-1487365468824-80e35a328956?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=1e48ae0dff505a5de752576ca697cdc3";
 };
 user =     {
     bio = "I shoot ... everything. And in between, I design cool things and watch crime documentary with my dog.";
     "first_name" = Alona;
     id = jA5IFe2s2DA;
     "last_name" = Kraft;
     links =         {
         followers = "https://api.unsplash.com/users/alena_kraft/followers";
         following = "https://api.unsplash.com/users/alena_kraft/following";
         html = "http://unsplash.com/@alena_kraft";
         likes = "https://api.unsplash.com/users/alena_kraft/likes";
         photos = "https://api.unsplash.com/users/alena_kraft/photos";
         portfolio = "https://api.unsplash.com/users/alena_kraft/portfolio";
         self = "https://api.unsplash.com/users/alena_kraft";
     };
     location = Berlin;
     name = "Alona Kraft";
     "portfolio_url" = "http://www.bandandroll.com";
     "profile_image" =         {
         large = "https:images.unsplash.com/profile-1485122127273-c6cea5fe6165?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=7695302bbfedb2496f47dd30066eca0d";
         medium = "https:images.unsplash.com/profile-1485122127273-c6cea5fe6165?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=96d71e48536ac0faf49a66b09bec553c";
         small = "https:images.unsplash.com/profile-1485122127273-c6cea5fe6165?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=951db2da91e8d098ca886f7b4e6ef344";
     };
     "total_collections" = 0;
     "total_likes" = 2;
     "total_photos" = 2;
     username = "alena_kraft";
 };
 width = 4788;
 }
 */




@end
