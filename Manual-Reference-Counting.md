# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // leak, adding an extra "retain" without calling release. 

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""]; //no alloc, copy, init, mutablecopy so no leak. Punctuationset's count goes up as it's been added to a set
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];   // No leak

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // Leak. No autorelease, no release further down.

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
            wordFrequency[word] = [[NSNumber alloc] initWithInteger:1]; // This is the only line in this loop that makes me raise an eyebrow. A new object is being initialized, but never released.
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    ```swift
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    ```

2. Which of these objects is autoreleased?  Why?

1. `NSDate *yesterday = [NSDate date];` // Here. It doesn't use any of the keywords that would increase retain count (new, alloc, init, copy, etc). Therefore it's safe to asssume it uses a convenience method to initialize an autoreleasing instance.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`

3. Explain when you need to use the `NSAutoreleasePool`.
It takes care of calling autorelease on all objects initialized withiin the block.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)personWithName:(NSString *)name;

@end

@implementation

- (instancetype)initWithName:(NSString *name) {
    if (self = [super init]) {
        _name = [name copy];
    }
    return self;
}

+ (instancetype)personWithName:(NSString *name) {
    return [[[Person alloc] initWithName:name] autorelease];
}

@end
```
