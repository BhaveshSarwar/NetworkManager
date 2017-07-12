//
//  ECRequestFactory.h
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

@import Foundation;

/**
 Declare all the types of request in the factory
 */

//Arch change: Add API: Step 5
// Add unique requestID if not present
enum : NSInteger {
    //Initial Setup
    RT_INITIAL_SETUP_GET_PAGE               =   1000,
    RT_INITIAL_SETUP_RUN_ACTION             =   1001,
    RT_INITIAL_SETUP_START_AUDIO_TEST       =   1002,
    RT_INITIAL_SETUP_YES_NO_OPTION          =   1003,
    
    //Wimp
    RT_WIMP_GET_CATEGORIES_ALBUM            =   2000,
    RT_WIMP_GET_CATEGORIES_ARTIST           =   2001,
    RT_WIMP_GET_CATEGORIES_TRACK            =   2002,
    RT_WIMP_GET_CATEGORIES_PLAYLIST         =   2003,
    RT_WIMP_FILTER_ALBUM_TYPE               =   2004,
    RT_WIMP_ALBUM_FOR_CAT_TYPE              =   2005,
    RT_WIMP_FILTER_ARTIST_TYPE              =   2006,
    RT_WIMP_ARTIST_FOR_CAT_TYPE             =   2007,
    RT_WIMP_SONGS_FOR_CAT_TYPE              =   2008,
    RT_WIMP_FILTER_PLAYLIST_TYPE            =   2009,
    RT_WIMP_PLAYLIST_FOR_CAT_TYPE           =   2010,
    RT_WIMP_GENERES_TYPE                    =   2011,
    RT_WIMP_ALBUM_FOR_GENERE_TYPE           =   2012,
    RT_WIMP_SET_ALBUM_ID_TYPE               =   2013,
    RT_WIMP_SET_ARTIST_ID_TYPE              =   2014,
    RT_WIMP_SET_SONG_ID_TYPE                =   2015,
    RT_WIMP_SET_PLAYLIST_ID_TYPE            =   2016,
    RT_WIMP_CREATE_PLAYLIST_TYPE            =   2017,
    RT_WIMP_ADD_SONG_TYPE                   =   2018,
    RT_WIMP_REMOVE_SONG_TYPE                =   2019,
    RT_WIMP_DELETE_PLAYLIST_TYPE            =   2020,
    RT_WIMP_ALBUM_FOR_ARTIST_TYPE           =   2021,
    RT_WIMP_VIDEO_FOR_ARTIST_TYPE           =   2022,
    RT_WIMP_SONG_FOR_ALBUM_TYPE             =   2023,
    RT_WIMP_SONG_FOR_PLAYLIST_TYPE          =   2024,
    RT_WIMP_SEARCH_SONG_TYPE                =   2025,
    RT_WIMP_QUEUE_ALBUM_TYPE                =   2026,
    RT_WIMP_QUEUE_PLAYLIST_TYPE             =   2027,
    RT_WIMP_QUEUE_ARTIST_TYPE               =   2028,
    RT_WIMP_QUEUE_SONG_TYPE                 =   2029,
    RT_WIMP_QUEUE_TRACKS_TYPE               =   2030,
    RT_WIMP_QUEUE_VIDEO_TYPE                =   2031,
    
    //TIDAL
    RT_TIDAL_GET_CATEGORIES_ALBUM           =   3000,
    RT_TIDAL_GET_CATEGORIES_ARTIST          =   3001,
    RT_TIDAL_GET_CATEGORIES_TRACK           =   3002,
    RT_TIDAL_GET_CATEGORIES_PLAYLIST        =   3003,
    RT_TIDAL_FILTER_ALBUM_TYPE              =   3004,
    RT_TIDAL_ALBUM_FOR_CAT_TYPE             =   3005,
    RT_TIDAL_FILTER_ARTIST_TYPE             =   3006,
    RT_TIDAL_ARTIST_FOR_CAT_TYPE            =   3007,
    RT_TIDAL_SONGS_FOR_CAT_TYPE             =   3008,
    RT_TIDAL_FILTER_PLAYLIST_TYPE           =   3009,
    RT_TIDAL_PLAYLIST_FOR_CAT_TYPE          =   3010,
    RT_TIDAL_GENERES_TYPE                   =   3011,
    RT_TIDAL_ALBUM_FOR_GENERE_TYPE          =   3012,
    RT_TIDAL_SET_ALBUM_ID_TYPE              =   3013,
    RT_TIDAL_SET_ARTIST_ID_TYPE             =   3014,
    RT_TIDAL_SET_SONG_ID_TYPE               =   3015,
    RT_TIDAL_SET_PLAYLIST_ID_TYPE           =   3016,
    RT_TIDAL_CREATE_PLAYLIST_TYPE           =   3017,
    RT_TIDAL_ADD_SONG_TYPE                  =   3018,
    RT_TIDAL_REMOVE_SONG_TYPE               =   3019,
    RT_TIDAL_DELETE_PLAYLIST_TYPE           =   3020,
    RT_TIDAL_ALBUM_FOR_ARTIST_TYPE          =   3021,
    RT_TIDAL_VIDEO_FOR_ARTIST_TYPE          =   3022,
    RT_TIDAL_SONG_FOR_ALBUM_TYPE            =   3023,
    RT_TIDAL_SONG_FOR_PLAYLIST_TYPE         =   3024,
    RT_TIDAL_SEARCH_SONG_TYPE               =   3025,
    RT_TIDAL_QUEUE_ALBUM_TYPE               =   3026,
    RT_TIDAL_QUEUE_PLAYLIST_TYPE            =   3027,
    RT_TIDAL_QUEUE_ARTIST_TYPE              =   3028,
    RT_TIDAL_QUEUE_SONG_TYPE                =   3029,
    RT_TIDAL_QUEUE_TRACKS_TYPE              =   3030,
    RT_TIDAL_QUEUE_VIDEO_TYPE               =   3031,
    
    //Qobuz
    RT_QOBUZ_GET_CAT_ALBUM_TYPE             =   4000,
    RT_QOBUZ_GET_CAT_ARTIST_TYPE            =   4001,
    RT_QOBUZ_GET_CAT_TRACK_TYPE             =   4002,
    RT_QOBUZ_GET_CAT_PLAYLIST_TYPE          =   4003,
    RT_QOBUZ_GET_GENRES_TYPE                =   4004,
    RT_QOBUZ_GET_CAT_GENRE_TYPE             =   4005,
    RT_QOBUZ_ALBUMS_FOR_PROPERTY_TYPE       =   4006,
    RT_QOBUZ_ALBUMS_FOR_ARTIST_TYPE         =   4007,
    RT_QOBUZ_ALBUMS_FOR_GENRE_TYPE          =   4008,
    RT_QOBUZ_TRACKS_FOR_PROPERTY_TYPE       =   4009,
    RT_QOBUZ_TRACKS_FOR_PLAYLIST_TYPE       =   4010,
    RT_QOBUZ_ARTISTS_FOR_PROPERTY_TYPE      =   4011,
    RT_QOBUZ_PLAYLISTS_FOR_PROPERTY_TYPE    =   4012,
    RT_QOBUZ_QUEUE_SONG_TYPE                =   4013,
    RT_QOBUZ_QUEUE_CATEGORY_TYPE            =   4014,
    RT_QOBUZ_QUEUE_ARTIST_TYPE              =   4015,
    RT_QOBUZ_QUEUE_PLAYLIST_TYPE            =   4016,
    RT_QOBUZ_SET_FAV_ALBUM_TYPE             =   4017,
    RT_QOBUZ_SET_FAV_ARTIST_TYPE            =   4018,
    RT_QOBUZ_SET_FAV_SONG_TYPE              =   4019,
    RT_QOBUZ_ADD_ITEM_TYPE                  =   4020,
    RT_QOBUZ_SUBSCRIBE_TYPE                 =   4021,
    
    //Youtube
    RT_YOUTUBE_GET_CAT_TYPE                 =   5000,
    RT_YOUTUBE_GET_CAT_OBJ_TYPE             =   5001,
    RT_YOUTUBE_GET_VIDEOS_FOR_CAT_TYPE      =   5002,
    RT_YOUTUBE_GET_VIDEOS_FOR_CAT_OBJ_TYPE  =   5003,
    RT_YOUTUBE_SEARCH_VIDEO_TYPE            =   5004,
    RT_YOUTUBE_SEARCH_VIDEO_OBJ_TYPE        =   5005,
    RT_YOUTUBE_PLAY_VIDEO_TYPE              =   5006,
    
    //Internet Radio
    RT_RADIO_GET_GENRES_TYPE                =   6000,
    RT_RADIO_GET_COUNTRIES_TYPE             =   6001,
    RT_RADIO_GET_STATIONS_FOR_GENRE_TYPE    =   6002,
    RT_RADIO_GET_STATIONS_FOR_COUNTRY_TYPE  =   6003,
    RT_RADIO_GET_STATIONS_FOR_CATEGORY_TYPE =   6004,
    RT_RADIO_SEARCH_STATIONS_TYPE           =   6005,
    RT_RADIO_PLAY_STATION_TYPE              =   6006,
    RT_RADIO_STATION_SET_FAV_TYPE           =   6007,
    
    //Settings
    RT_GET_SETTINGS_TYPE                    =   7000,
    RT_SETTINGS_GET_PROVIDER_TYPE           =   7001,
    RT_SET_SETTINGS_TYPE                    =   7002,
    RT_SETTINGS_SET_NETWORK_TYPE            =   7003,
    RT_SETTINGS_SET_SSID_TYPE               =   7004,
    RT_SETTINGS_SET_ETH_NETWORK_TYPE        =   7005,
    RT_SETTINGS_SET_SSID_FOR_NET_TYPE       =   7006,
    RT_SETTINGS_RUN_ACTION_TYPE             =   7007,
    RT_GET_SYSTEM_STATUS_TYPE               =   7008,
    
    //Library
    RT_LIB_GET_CURRENT_AUDIO_SOURCES_TYPE   =   8000,
    RT_LIB_GET_CURRENT_VIDEO_SOURCES_TYPE   =   8001,
    RT_LIB_GET_CURRENT_TV_SOURCES_TYPE      =   8002,
    RT_LIB_GET_AVAILABLE_SOURCES_TYPE       =   8003,
    RT_LIB_ADD_SOURCE_TYPE                  =   8004,
    RT_LIB_REMOVE_SOURCE_TYPE               =   8005,
    RT_LIB_GET_REMOVABLE_DRIVES_TYPE        =   8006,
    RT_LIB_GET_HOSTS_TYPE                   =   8007,
    RT_LIB_UPDATE_DIRECTORY_TYPE            =   8008,
    RT_LIB_UPDATE_SOURCE_TYPE               =   8009,
    RT_LIB_SET_FOLDER_CRED_TYPE             =   8010,
    
    //Speaker Config
    RT_SPEAKER_GET_CONFIG_TYPE              =   9000,
    RT_SPEAKER_SET_CONFIG_TYPE              =   9001,
    RT_SPEAKER_DISCOVER_TYPE                =   9002,
    RT_TEST_SPEAKER_TYPE                    =   9003,
    RT_SPEAKER_REMOVE_TYPE                  =   9004,
    RT_REMOVE_ALL_SPEAKER_TYPE              =   9005,
    
    //Playlist
    RT_PLAYLIST_CLEAR_TYPE                  =   1100,
    RT_PLAYLIST_PLAY_ITEM_TYPE              =   1101,
    RT_PLAYLIST_GET_ITEM_TYPE               =   1102,
    RT_PLAYLIST_REMOVE_TYPE                 =   1103,
    RT_PLAYLIST_INSERT_TYPE                 =   1104,
    RT_PLAYLIST_ADD_TYPE                    =   1105,
    
    //Albums
    RT_GET_ALL_ALBUMS_TYPE                  =   1200,
    RT_GET_ALL_SONGS_TYPE                   =   1201,
    RT_GET_ALBUM_DETAILS_TYPE               =   1202,
    RT_GET_ARTIST_DETAILS_TYPE              =   1203,
    RT_GET_ALBUMS_FOR_ARTIST_TYPE           =   1204,
    RT_GET_ALL_SONGS_SINGLE_ALBUM_TYPE      =   1205,
    
    //Player
    RT_PLAYER_SEEK_TYPE                     =   1300,
    RT_GET_ACTIVE_PLAYER_TYPE               =   1301,
    RT_PLAYER_GET_ITEM_TYPE                 =   1302,
    RT_PLAYER_GET_PROPERTIES_TYPE           =   1303,
    RT_PLAYER_OPEN_TYPE                     =   1304,
    RT_GET_APP_PROPERTIES_TYPE              =   1305,
    RT_SET_APP_VOLUME_TYPE                  =   1306,
    RT_SEND_INSERT_TEXT_TYPE                =   1307,
    
    
    RT_PLAYER_PLAY_PAUSE_TYPE               =   1308,
    RT_PLAYER_STOP_TYPE                     =   1309,
    RT_PLAYER_PLAY_NEXT_TYPE                =   1310,
    RT_PLAYER_PLAY_PREVIOUS_TYPE            =   1311,
    RT_PLAYER_SHUFFLE_TYPE                  =   1312,
    RT_PLAYER_REPEAT_TYPE                   =   1313,
    RT_PLAYER_GET_LABEL_TYPE                =   1314,
    
    //Movies
    RT_GET_ALL_MOVIES_TYPE                  =   1400,
    RT_GET_ALL_VIDEO_GENRE_TYPE             =   1401,
    
    //TvShows
    RT_GET_ALL_TV_SHOWS_TYPE                =   1500,
    RT_GET_ALL_SEASONS_TYPE                 =   1501,
    RT_GET_ALL_EPISODES_TYPE                =   1502,
    RT_GET_TV_SHOW_DETAILS_TYPE             =   1503,
    
    //Input
    RT_GET_INPUT_TYPE                       =   1601,
    RT_SET_INPUT_TYPE                       =   1602,
}ECRequestType;


enum : NSInteger {
//Input
GET                       =   0,
POST                       =   1,
}RequestType;

@protocol GatewayRequest <NSObject>
@property (nonatomic) long long requestIdentifier;
@property (nonatomic) long long taskIdentifier;
@property (nonatomic) long long requestType;
@property (nonatomic, strong) NSString* requestString;
@property (nonatomic,strong) NSDictionary * requestParameters;
@property (nonatomic,strong) NSDictionary * headerParameters;
@property (nonatomic) NSUInteger requestStrategy;
@property (nonatomic, weak) id delegate;
@property bool isJSONRequest;
@required
- (void) sendRequest;
@optional
- (void) parseResponse:(NSDictionary*)responseDictionary;
- (void) requestFailed:(NSError *)error;
@end

@interface ECRequestFactory : NSObject

/**
 
 All the VCs will call the method
 with the ECrequestType as reqType parameter
 and dictionary of params as optional
 
 */
+ (ECRequestFactory*)sharedInstance;
//+ (id<GatewayRequest>)requestForAPI:(NSInteger)reqType parameters:(NSDictionary *)params withStrategy:(NSInteger)strategyType forDelegate:(id)delegate;
@end
