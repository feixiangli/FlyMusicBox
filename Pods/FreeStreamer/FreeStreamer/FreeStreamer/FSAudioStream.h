/*
 * This file is part of the FreeStreamer project,
 * (C)Copyright 2011-2016 Matias Muhonen <mmu@iki.fi> 穆马帝
 * See the file ''LICENSE'' for using the code.
 *
 * https://github.com/muhku/FreeStreamer
 */

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>

/**
 * The major version of the current release.*主要版本的当前版本。
 */
#define FREESTREAMER_VERSION_MAJOR          3

/**
 * The minor version of the current release. *当前版本的小版本。
 */
#define FREESTREAMER_VERSION_MINOR          5

/**
 * The reversion of the current release*当前版本的回归
 */
#define FREESTREAMER_VERSION_REVISION       4

/**
 * Follow this notification for the audio stream state changes.*遵循这个音频流状态更改通知。
 */
extern NSString* const FSAudioStreamStateChangeNotification;
extern NSString* const FSAudioStreamNotificationKey_State;

/**
 * Follow this notification for the audio stream errors.*按照这个通知的音频流错误。
 */
extern NSString* const FSAudioStreamErrorNotification;
extern NSString* const FSAudioStreamNotificationKey_Error;

/**
 * Follow this notification for the audio stream metadata.*按照这个通知的音频流的元数据。
 */
extern NSString* const FSAudioStreamMetaDataNotification;
extern NSString* const FSAudioStreamNotificationKey_MetaData;

/**
 * The audio stream state.*音频流的状态。
 */
typedef NS_ENUM(NSInteger, FSAudioStreamState) {
    /**
     * Retrieving URL.*检索URL。
     */
    kFsAudioStreamRetrievingURL,
    /**
     * Stopped.*停了下来。
     */
    kFsAudioStreamStopped,
    /**
     * Buffering.*缓冲。
     */
    kFsAudioStreamBuffering,
    /**
     * Playing.播放中
     */
    kFsAudioStreamPlaying,
    /**
     * Paused.*停了下来。
     */
    kFsAudioStreamPaused,
    /**
     * Seeking.*寻求。
     */
    kFsAudioStreamSeeking,
    /**
     * The stream has received all the data for a file.*流已经收到了所有的数据文件。
     */
    kFSAudioStreamEndOfFile,
    /**
     * Failed.*失败了。
     */
    kFsAudioStreamFailed,
    /**
     * Started retrying.*开始进行重试。
     */
    kFsAudioStreamRetryingStarted,
    /**
     * Retrying succeeded.*重新尝试成功了。
     */
    kFsAudioStreamRetryingSucceeded,
    /**
     * Retrying failed.*重新尝试失败了。
     */
    kFsAudioStreamRetryingFailed,
    /**
     * Playback completed.*播放完成。
     */
    kFsAudioStreamPlaybackCompleted,
    /**
     * Unknown state.*未知状态。
     */
    kFsAudioStreamUnknownState
};

/**
 * The audio stream errors.*音频流错误。
 */
typedef NS_ENUM(NSInteger, FSAudioStreamError) {
    /**
     * No error.*没有错误。
     */
    kFsAudioStreamErrorNone = 0,
    /**
     * Error opening the stream.*错误打开流。
     */
    kFsAudioStreamErrorOpen = 1,
    /**
     * Error parsing the stream.*误差解析流。
     */
    kFsAudioStreamErrorStreamParse = 2,
    /**
     * Network error.*网络错误。
     */
    kFsAudioStreamErrorNetwork = 3,
    /**
     * Unsupported format.*不支持的格式。
     */
    kFsAudioStreamErrorUnsupportedFormat = 4,
    /**
     * Stream buffered too often.*流缓冲过于频繁。
     */
    kFsAudioStreamErrorStreamBouncing = 5,
    /**
     * Stream playback was terminated by the operating system.*流播放由操作系统终止。
     */
    kFsAudioStreamErrorTerminated = 6
};

@protocol FSPCMAudioStreamDelegate;
@class FSAudioStreamPrivate;

/**
 * The audio stream playback position.*音频流播放的位置。
 */
typedef struct {
    
    unsigned minute;
    unsigned second;
    
    /**
     * Playback time in seconds.*播放时间在秒。
     */
    float playbackTimeInSeconds;
    
    /**
     * Position within the stream, where 0 is the beginning*流中的位置,0是开始的地方
     * and 1.0 is the end.* 1.0就是终结。
     */
    float position;
    
} FSStreamPosition;

/**
 * The audio stream seek byte offset.*音频流寻求字节偏移量。
 */
typedef struct {
    UInt64 start;
    UInt64 end;
    /**
     * Position within the stream, where 0 is the beginning*流中的位置,0是开始的地方
     * and 1.0 is the end.* 1.0就是终结。
     */
    float position;
} FSSeekByteOffset;

/**
 * Audio levels.
 */
typedef struct {
    Float32 averagePower;
    Float32 peakPower;
} FSLevelMeterState;

/**
 * The low-level stream configuration.*低级流配置。
 */
@interface FSStreamConfiguration : NSObject {
}

/**
 * The number of buffers.*缓冲区的数量。
 */
@property (nonatomic,assign) unsigned bufferCount;
/**
 * The size of each buffer.*每个缓冲区的大小。
 */
@property (nonatomic,assign) unsigned bufferSize;
/**
 * The number of packet descriptions.*包的数量描述。
 */
@property (nonatomic,assign) unsigned maxPacketDescs;
/**
 * The HTTP connection buffer size.* HTTP连接缓冲区大小。
 */
@property (nonatomic,assign) unsigned httpConnectionBufferSize;
/**
 * The output sample rate.*输出采样率。
 */
@property (nonatomic,assign) double   outputSampleRate;
/**
 * The number of output channels.*输出通道的数量。
 */
@property (nonatomic,assign) long     outputNumChannels;
/**
 * The interval within the stream may enter to the buffering state before it fails.*流内的间隔可以进入到缓冲状态之前失败。
 */
@property (nonatomic,assign) int      bounceInterval;
/**
 * The number of times the stream may enter the buffering state before it fails.*流的次数可能之前进入缓冲状态失败。
 */
@property (nonatomic,assign) int      maxBounceCount;
/**
 * The stream must start within this seconds before it fails.*流必须开始在这一秒之前失败。
 */
@property (nonatomic,assign) int      startupWatchdogPeriod;
/**
 * Allow buffering of this many bytes before the cache is full.*前允许这么多字节缓冲高速缓存已满。
 */
@property (nonatomic,assign) int      maxPrebufferedByteCount;
/**
 * Calculate prebuffer sizes dynamically using the stream bitrate in seconds instead of bytes.*计算prebuffer大小使用流动态比特率在几秒钟内,而不是字节。
 */
@property (nonatomic,assign) BOOL     usePrebufferSizeCalculationInSeconds;
/**
 * Calculate prebuffer sizes using the packet counts.*计算prebuffer大小使用的数据包数量。
 */
@property (nonatomic,assign) BOOL     usePrebufferSizeCalculationInPackets;
/**
 * Require buffering of this many bytes before the playback can start for a continuous stream.*需要缓冲的这么多字节回放之前可以开始连续流。
 */
@property (nonatomic,assign) float      requiredPrebufferSizeInSeconds;
/**
 * Require buffering of this many bytes before the playback can start for a continuous stream.*需要缓冲的这么多字节回放之前可以开始连续流。
 */
@property (nonatomic,assign) int      requiredInitialPrebufferedByteCountForContinuousStream;
/**
 * Require buffering of this many bytes before the playback can start a non-continuous stream.*需要缓冲的这么多字节回放之前可以开始连续流。
 */
@property (nonatomic,assign) int      requiredInitialPrebufferedByteCountForNonContinuousStream;
/**
 * Require buffering of this many packets before the playback can start.*需要缓冲的这许多数据包回放之前可以开始。
 */
@property (nonatomic,assign) int      requiredInitialPrebufferedPacketCount;
/**
 * The HTTP user agent used for stream operations.* HTTP用户代理用于流操作。
 */
@property (nonatomic,strong) NSString *userAgent;
/**
 * The directory used for caching the streamed files.*用于缓存流文件的目录。
 */
@property (nonatomic,strong) NSString *cacheDirectory;
/**
 * The HTTP headers that are appended to the request when the streaming starts. Notice*的HTTP头信息附加到请求流启动时。请注意
 * that the headers override any headers previously set by FreeStreamer.*标题覆盖任何头FreeStreamer之前设置的。
 */
@property (nonatomic,strong) NSDictionary *predefinedHttpHeaderValues;
/**
 * The property determining if caching the streams to the disk is enabled.*属性决定是否启用缓存流到磁盘。
 */
@property (nonatomic,assign) BOOL cacheEnabled;
/**
 * The property determining if seeking from the audio packets stored in cache is enabled.*属性确定寻求从音频数据包存储在缓存启用。
 * The benefit is that seeking is faster in the case the audio packets are already cached in memory.*的好处是,寻求更快的音频数据包已经缓存在内存中。
 */
@property (nonatomic,assign) BOOL seekingFromCacheEnabled;
/**
 * The property determining if FreeStreamer should handle audio session automatically.*属性确定FreeStreamer应该自动处理音频会话。
 * Leave it on if you don't want to handle the audio session by yourself.*把它如果你不想处理音频会话自己。
 */
@property (nonatomic,assign) BOOL automaticAudioSessionHandlingEnabled;
/**
 * The property enables time and pitch conversion for the audio queue. Put it on
 * if you want to use the play rate setting.属性使时间和距转换为音频队列。把它放在*如果你想使用播放率设置。
 */
@property (nonatomic,assign) BOOL enableTimeAndPitchConversion;
/**
 * Requires the content type given by the server to match an audio content type.*需要的内容类型服务器匹配一个音频内容类型。
 */
@property (nonatomic,assign) BOOL requireStrictContentTypeChecking;
/**
 * The maximum size of the disk cache in bytes.*的最大大小字节的磁盘高速缓存。
 */
@property (nonatomic,assign) int maxDiskCacheSize;

@end

/**
 * Statistics on the stream state.*数据流的状态。
 */
@interface FSStreamStatistics : NSObject {
}

/**
 * Time when the statistics were gathered.*当统计数据聚集。
 */
@property (nonatomic,strong) NSDate *snapshotTime;
/**
 * Time in a pretty format.*时间在一个漂亮的格式。
 */
@property (nonatomic,readonly) NSString *snapshotTimeFormatted;
/**
 * Audio stream packet count.*音频流包数。
 */
@property (nonatomic,assign) NSUInteger audioStreamPacketCount;
/**
 * Audio queue used buffers count.*音频队列缓冲区使用计数。
 */
@property (nonatomic,assign) NSUInteger audioQueueUsedBufferCount;
/**
 * Audio stream PCM packet queue count.* PCM音频流数据包队列计数。
 */
@property (nonatomic,assign) NSUInteger audioQueuePCMPacketQueueCount;

@end

NSString*             freeStreamerReleaseVersion();

/**
 * FSAudioStream is a class for streaming audio files from an URL.
 * It must be directly fed with an URL, which contains audio. That is,
 * playlists or other non-audio formats yield an error.
 *
 * To start playback, the stream must be either initialized with an URL
 * or the playback URL can be set with the url property. The playback
 * is started with the play method. It is possible to pause or stop
 * the stream with the respective methods.
 *
 * Non-continuous streams (audio streams with a known duration) can be
 * seeked with the seekToPosition method.
 *
 * Note that FSAudioStream is not designed to be thread-safe! That means
 * that using the streamer from multiple threads without syncronization
 * could cause problems. It is recommended to keep the streamer in the
 * main thread and call the streamer methods only from the main thread
 * (consider using performSelectorOnMainThread: if calls from multiple
 * threads are needed).
 FSAudioStream流式音频文件是一个类从一个URL。*必须直接用一个URL,其中包含音频。也就是说,*播放列表或其他non-audio格式产生一个错误。**开始播放,流必须初始化一个URL*或回放URL可以设置URL属性。播放*是开始玩的方法。可以暂停或停止*用各自的方法。**非连续流(音频流与一个已知的时间)*与seekToPosition提议的方法。**注意FSAudioStream不是设计成线程安全的!这意味着*没有同步法,使用多个线程的流光*可能导致问题。建议保持的流光*主线程,仅从主线程调用闪流方法*(考虑使用performSelectorOnMainThread:如果从多个电话*需要线程)。
 */
@interface FSAudioStream : NSObject {
    FSAudioStreamPrivate *_private;
}

/**
 * Initializes the audio stream with an URL.*初始化音频流和一个URL。
 *
 * @param url The URL from which the stream data is retrieved.* @param url检索url的流数据。
 */
- (id)initWithUrl:(NSURL *)url;

/**
 * Initializes the stream with a configuration.*初始化流配置。
 *
 * @param configuration The stream configuration. 配置流配置。
 */
- (id)initWithConfiguration:(FSStreamConfiguration *)configuration;

/**
 * Starts preload the stream. If no preload URL is
 * defined, an error will occur.开始预流。如果没有预加载URL*定义,就会发生错误。
 */
- (void)preload;

/**
 * Starts playing the stream. If no playback URL is
 * defined, an error will occur.开始播放流。如果没有回放URL*定义,就会发生错误。
 */
- (void)play;

/**
 * Starts playing the stream from the given URL.*开始播放流从给定的URL。
 *
 * @param url The URL from which the stream data is retrieved.url检索url的流数据。
 */
- (void)playFromURL:(NSURL*)url;

/**
 * Starts playing the stream from the given offset.
 * The offset can be retrieved from the stream with the
 * currentSeekByteOffset property.
 *开始播放流从给定的偏移量。*偏移量可以从流与检索* currentSeekByteOffset财产。
 * @param offset The offset where to start playback from. 消抵消从哪里开始播放
 */
- (void)playFromOffset:(FSSeekByteOffset)offset;

/**
 * Stops the stream playback.*停止播放。
 */
- (void)stop;

/**
 * If the stream is playing, the stream playback is paused upon calling pause.
 * Otherwise (the stream is paused), calling pause will continue the playback.如果流是玩,流播放暂停叫暂停。*否则(流停了),要求暂停将继续播放
 */
- (void)pause;

/**
 * Rewinds the stream. Only possible for continuous streams.
 **倒带。唯一可能的连续流。
 * @param seconds Seconds to rewind the stream.秒秒退。
 */
- (void)rewind:(unsigned)seconds;

/**
 * Seeks the stream to a given position. Requires a non-continuous stream
 * (a stream with a known duration).寻求流到一个给定的位置。需要一个非连续流*(流与一个已知的时间)。
 *
 * @param position The stream position to seek to.寻求位置流位置
 */
- (void)seekToPosition:(FSStreamPosition)position;

/**
 * Sets the audio stream playback rate from 0.5 to 2.0.
 * Value 1.0 means the normal playback rate. Values below
 * 1.0 means a slower playback rate than usual and above
 * 1.0 a faster playback rate. Notice that using a faster
 * playback rate than 1.0 may mean that you have to increase
 * the buffer sizes for the stream still to play.
 *
 * The play rate has only effect if the stream is playing.
 *设置音频流播放率从0.5到2.0。*值1.0意味着正常的播放速度。下面的值* 1.0意味着回放速度比平时慢及以上* 1.0更快的回放速度。请注意,使用更快*回放速度比1.0可能意味着你必须增加*仍然流的缓冲区大小。**播放率只有效果如果流玩。*
 * @param playRate The playback rate.playRate回放速度
 */
- (void)setPlayRate:(float)playRate;

/***返回播放状态:是的如果流玩,没有否则。
 * Returns the playback status: YES if the stream is playing, NO otherwise.
 */
- (BOOL)isPlaying;

/**
 * Cleans all cached data from the persistent storage.*清洁所有缓存数据的持久存储。
 */
- (void)expungeCache;

/**
 * The stream URL.
 */
@property (nonatomic,assign) NSURL *url;
/**
 * Determines if strict content type checking  is required. If the audio stream
 * cannot determine that the stream is actually an audio stream, the stream
 * does not play. Disabling strict content type checking bypasses the
 * stream content type checks and tries to play the stream regardless
 * of the content type information given by the server.决定是否需要严格的类型检查的内容。如果音频流*不能确定流实际上是一个音频流,流*不玩。禁用严格的类型检查绕过了内容*流内容类型检查和试图扮演流*内容的类型信息的服务器。* /
 */
@property (nonatomic,assign) BOOL strictContentTypeChecking;
/**
 * Set an output file to store the stream contents to a file.*设置一个输出文件流的内容存储到一个文件中。
 */
@property (nonatomic,assign) NSURL *outputFile;
/**
 * Sets a default content type for the stream. Used if
 * the stream content type is not available.设置一个默认内容类型。如果使用*流内容类型是不可用的。
 */
@property (nonatomic,assign) NSString *defaultContentType;
/**
 * The property has the content type of the stream, for instance audio/mpeg.*属性流的内容类型,例如音频/ mpeg。
 */
@property (nonatomic,readonly) NSString *contentType;
/**
 * The property has the suggested file extension for the stream based on the stream content type.显示文件扩展名的属性流基于流的内容类型。
 */
@property (nonatomic,readonly) NSString *suggestedFileExtension;
/**
 * Sets a default content length for the stream.  Used if
 * the stream content-length is not available.设置一个默认的内容长度的流。如果使用*流内容长度不可用。
 */
@property (nonatomic, assign) UInt64 defaultContentLength;
/**
 * The property has the content length of the stream (in bytes). The length is zero if
 * the stream is continuous.流的属性内容长度(字节数)。长度为零*流是连续的。
 */
@property (nonatomic,readonly) UInt64 contentLength;
/**
 * This property has the current playback position, if the stream is non-continuous.这个属性当前播放位置,如果流是不连续的。
 * The current playback position cannot be determined for continuous streams.*当前播放位置不能确定的连续流。
 */
@property (nonatomic,readonly) FSStreamPosition currentTimePlayed;
/**
 * This property has the duration of the stream, if the stream is non-continuous.*这个属性的时间流,如果流是不连续的。
 * Continuous streams do not have a duration.*连续流没有持续时间。
 */
@property (nonatomic,readonly) FSStreamPosition duration;
/**
 * This property has the current seek byte offset of the stream, if the stream is non-continuous.*这个属性的当前寻求字节抵消流,如果流是不连续的。
 * Continuous streams do not have a seek byte offset.*连续流没有寻求字节偏移量。
 */
@property (nonatomic,readonly) FSSeekByteOffset currentSeekByteOffset;
/**
 * This property has the bit rate of the stream. The bit rate is initially 0,
 * before the stream has processed enough packets to calculate the bit rate.这个属性流的比特率。比特率是0,*前流处理足够的数据包来计算比特率。
 */
@property (nonatomic,readonly) float bitRate;
/**
 * The property is true if the stream is continuous (no known duration).*属性是真的如果流连续的(没有已知的时间)。
 */
@property (nonatomic,readonly) BOOL continuous;
/**
 * The property is true if the stream has been cached locally.*属性是真的如果流已经在本地缓存。
 */
@property (nonatomic,readonly) BOOL cached;
/**
 * This property has the number of bytes buffered for this stream.*该属性已经为这个流缓冲的字节数。
 */
@property (nonatomic,readonly) size_t prebufferedByteCount;
/**
 * This property holds the current playback volume of the stream,
 * from 0.0 to 1.0.这个属性保存当前播放的流,*从0.0到1.0。
 *
 * Note that the overall volume is still constrained by the volume
 * set by the user! So the actual volume cannot be higher
 * than the volume currently set by the user. For example, if
 * requesting a volume of 0.5, then the volume will be 50%
 * lower than the current playback volume set by the user.注意,总量仍受制于体积*用户设定的!所以实际体积不能更高*体积比目前设定的用户。例如,如果*要求的体积是0.5,然后体积将是50%*低于当前的播放音量设定的用户。
 */
@property (nonatomic,assign) float volume;
/**
 * The current size of the disk cache.*当前磁盘高速缓存的大小。
 */
@property (nonatomic,readonly) unsigned long long totalCachedObjectsSize;
/**
 * The property determines the amount of times the stream has tried to retry the playback
 * in case of failure.属性决定了倍流的数量一直试图重新回放在失败的情况下。
 */
@property (nonatomic,readonly) NSUInteger retryCount;
/**
 * Holds the maximum amount of playback retries that will be 
 * performed before entering kFsAudioStreamRetryingFailed state.
 * Default is 3.拥有最大的回放重试*进入kFsAudioStreamRetryingFailed之前执行的状态。*默认是3。
 */
@property (nonatomic,assign) NSUInteger maxRetryCount;
/**
 * The property determines the current audio levels.@ property(原子,分配)了NSUInteger maxRetryCount;
 */
@property (nonatomic,readonly) FSLevelMeterState levels;
/**
 * This property holds the current statistics for the stream state.*这个属性保存当前统计数据流状态。
 */
@property (nonatomic,readonly) FSStreamStatistics *statistics;
/**
 * Called upon completion of the stream. Note that for continuous
 * streams this is never called.
 要求完成流。请注意,连续这从来都不是叫*流。
 */
@property (copy) void (^onCompletion)();
/**
 * Called upon a state change.*呼吁改变状态。
 */
@property (copy) void (^onStateChange)(FSAudioStreamState state);
/**
 * Called upon a meta data is available.*呼吁一个元数据是可用的。
 */
@property (copy) void (^onMetaDataAvailable)(NSDictionary *metadata);
/**
 * Called upon a failure.*要求失败。
 */
@property (copy) void (^onFailure)(FSAudioStreamError error, NSString *errorDescription);
/**
 * The property has the low-level stream configuration.*属性的低级流配置。
 */
@property (readonly) FSStreamConfiguration *configuration;
/**
 * Delegate.*委托。
 */
@property (nonatomic,unsafe_unretained) IBOutlet id<FSPCMAudioStreamDelegate> delegate;

@end

/**
 * To access the PCM audio data, use this delegate.*访问PCM音频数据,使用这个委托。
 */
@protocol FSPCMAudioStreamDelegate <NSObject>

@optional
/**
 * Called when there are PCM audio samples available. Do not do any blocking operations
 * when you receive the data. Instead, copy the data and process it so that the
 * main event loop doesn't block. Failing to do so may cause glitches to the audio playback.
 *
 * Notice that the delegate callback may occur from other than the main thread so make
 * sure your delegate code is thread safe.当有可用的PCM音频样本。不做任何阻塞操作吗*当你收到数据。相反,复制数据和处理它的*主事件循环不会阻止。未能这样做可能会导致故障音频回放。**请注意,委托从主线程之外可能出现回调*确保委托代码是线程安全的。
 *
 * @param audioStream The audio stream the samples are from.
 * @param samples The samples as a buffer list.
 * @param frames The number of frames.
 * @param description Description of the data provided.
 
 */
- (void)audioStream:(FSAudioStream *)audioStream samplesAvailable:(AudioBufferList *)samples frames:(UInt32)frames description: (AudioStreamPacketDescription)description;
@end
