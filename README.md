# RVCache

# Use dev branch for MVRCache App.
# Use FrameworkBuild branch for MVCacheManager Framework.

MVRCache is a Swift library for caching images and json files.

## Installation

Add MVCacheManager.Framework in your project and import it.

## Usage

CacheManager.manage.cacheResponseFromURL(sourceURL: url, shouldStoreInCache: true, cacheType: .Image) { (outputObject, error, CurrentCacheType) in
            
            switch CurrentCacheType {
            case .Image:
                DispatchQueue.main.async {
                    self.userImageView.image = outputObject as? UIImage
                }
                break
            case .JSON:
                break
            case .Zip:
                break
            }
        }


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
