// Script Name:    img-reducer-lamda-script.js
// Description:    Function for lambda to reduce our image 
// Author:         Ajnur Ademi | Aron Herbel | Nicolas Haas
// Date:           26. March 2024
// Version:        1.3

'use strict';
const AWS = require('aws-sdk');
const sharp = require('sharp');

exports.handler = async (event, context) => {
    // Initializing AWS S3 and Sharp
    const s3Instance = new AWS.S3();

    // Extracting information from the event
    const bucketOriginal = event.Records[0].s3.bucket.name;
    const filename = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));

    // Percentage resize from environment variables
    let percentageResize = process.env.PERCENTAGE_RESIZE;

    try {
        // Retrieving the original image from S3
        const data = await s3Instance.getObject({ Bucket: bucketOriginal, Key: filename }).promise();
        const image = sharp(data.Body);

        // Retrieving metadata of the original image
        const metadata = await image.metadata();
        let size = Math.round(metadata.width * percentageResize / 100);

        // Resizing the image
        console.log(`Resizing ${filename} to ${size}`);
        let resizedImage = await image.resize(size).toBuffer();

        // Uploading the resized image to a target bucket
        await s3Instance.putObject({
            Body: resizedImage,
            Bucket: process.env.TARGET_BUCKET_NAME,
            Key: `resized-${filename}`,
            ContentType: 'image/jpeg'
        }).promise();

        console.log(`Resized ${filename} and uploaded to target bucket`);

    } catch (err) {
        console.error(err);
    }
};