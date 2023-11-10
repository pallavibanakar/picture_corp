# The Big Picture Corp

A small application to download list of images

## Requirements/Installations

- Install Ruby - Version 3.2.0
- Install bundler - `gem install bundler`
- Install gems - `bundle install`

### Running the rake task
- Below command will run the task with default values for source file(`example_source_urls.txt`) and destination path to be `/tmp` directory  
    ```
    rake "picture_corp:download_images
    ```

- With arguments for source file and destination path,  
    ```
    rake picture_corp:download_images[<dest_file_path>, <source_file_path>]
    ``` 
    Below is the example command for the same  
    ```
    rake "picture_corp:download_images[downloads, /home/picture_corp_image_urls.txt]"
    ```

### Documentation

Picture Corp is the app used to download images from the list of remote URLs(Currently read from a file)  

- Picture Client(services/picture_client.rb)  
The picture client has the main responsibility to read the image from the URL and write it to the specified destination path.
This module will raise meaningful errors by validating paths and URLs in addition to handling images not being read and writing to local file errors.  
By having this module we can make sure to use this for single or multiple image downloads.Also can extend this module to many other use cases like resizing downloaded images etc.   
On having the client separately, we can thread image download operation more effectively which leads to good performance by parallelizing the download operation.

- Errors(lib/errors)  
The errors mentioned above like valid paths, URLs, read errors, and others are classified under super class download errors and these can be handled as failed image downloads when operating on multiple image downloads and continued with other image downloads.

- Main(main.rb)  
The main function of the app is to receive an array of image URLs and download them to the destination path. This uses a picture client to download each image.   Here have parallized the download of the list of images and also made sure to return the successful download paths and failed URLs from the list. If we decide to do the list of images in batches can use the same function with the same or different destination download path for each batch.

- Rakefile  
Validating and reading source files to fetch image URLs and using the main function to download images to a given destination path.
