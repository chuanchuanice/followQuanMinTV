//
//  TRRoomModel.h
//  TRProject
//
//  Created by tarena on 2017/2/3.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TRRoomLiveModel,TRRoomLiveWsModel,TRRoomLiveWsHFModel,TRRoomRankCurrModel,TRRoomLinesModel,TRRoomLiveWsHFDetailModel;
@interface TRRoomModel : NSObject


@property (nonatomic, copy) NSString *nick;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, strong) NSArray *notice;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *last_play_at;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, strong) NSArray *admins;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, assign) BOOL hidden;

@property (nonatomic, assign) NSInteger view;

@property (nonatomic, assign) BOOL forbid_status;

@property (nonatomic, assign) NSInteger watermark;

@property (nonatomic, assign) NSInteger no;

@property (nonatomic, copy) NSString *watermark_pic;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, strong) TRRoomLiveModel *live;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, strong) NSArray *rank_week;

@property (nonatomic, strong) NSArray<TRRoomLinesModel *> *room_lines;

@property (nonatomic, assign) BOOL is_star;

@property (nonatomic, strong) NSArray *rank_total;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, strong) NSArray<TRRoomRankCurrModel *> *rank_curr;

@property (nonatomic, copy) NSString *video_quality;

@property (nonatomic, copy) NSString *special;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, strong) NSArray<NSString *> *hot_word;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *play_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, assign) BOOL police_forbid;

@end
@interface TRRoomLiveModel : NSObject

@property (nonatomic, strong) TRRoomLiveWsModel *ws;

@end

@interface TRRoomLiveWsModel : NSObject

@property (nonatomic, strong) TRRoomLiveWsHFModel *hls;

@property (nonatomic, copy) NSString *def_mobile;

@property (nonatomic, copy) NSString *def_pc;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) TRRoomLiveWsHFModel *flv;

@property (nonatomic, copy) NSString *v;

@end

@interface TRRoomLiveWsHFModel : NSObject
//3 -> three
@property (nonatomic, strong) TRRoomLiveWsHFDetailModel *three;

@property (nonatomic, assign) NSInteger main_mobile;
//4 -> four
@property (nonatomic, strong) TRRoomLiveWsHFDetailModel *four;

@property (nonatomic, assign) NSInteger main_pc;
//5 -> five
@property (nonatomic, strong) TRRoomLiveWsHFDetailModel *five;

@end

@interface  TRRoomLiveWsHFDetailModel: NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end


@interface TRRoomRankCurrModel : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, copy) NSString *send_uid;

@property (nonatomic, copy) NSString *send_nick;

@end

@interface TRRoomLinesModel : NSObject

@property (nonatomic, strong) TRRoomLiveWsHFModel *hls;

@property (nonatomic, copy) NSString *def_mobile;

@property (nonatomic, copy) NSString *def_pc;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) TRRoomLiveWsHFModel *flv;

@property (nonatomic, copy) NSString *v;

@end




