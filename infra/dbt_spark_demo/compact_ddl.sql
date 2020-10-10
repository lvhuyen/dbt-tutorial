CREATE EXTERNAL TABLE cloudtrail_raw.cloudtrail_event (

     `Records` array<
        struct<
            `additionalEventData`:struct<
                `AuthenticationMethod`:string,
                `CipherSuite`:string,
                `LakeFormationTrustedCallerInvocation`:string,
                `SignatureVersion`:string,
                `insufficientLakeFormationPermissions`:array<
                    string>,
                `lakeFormationPrincipal`:string>,
            `apiVersion`:string,
            `awsRegion`:string,
            `errorCode`:string,
            `errorMessage`:string,
            `eventID`:string,
            `eventName`:string,
            `eventSource`:string,
            `eventTime`:string,
            `eventType`:string,
            `eventVersion`:string,
            `readOnly`:boolean,
            `recipientAccountId`:string,
            `requestID`:string,
            `requestParameters`:string,
            `resources`:array<
                struct<
                    `ARN`:string,
                    `accountId`:string,
                    `type`:string>>,
            `responseElements`:string,
            `serviceEventDetails`:struct<
                `snapshotId`:string>,
            `sharedEventID`:string,
            `sourceIPAddress`:string,
            `userAgent`:string,
            `userIdentity`:struct<
                `accessKeyId`:string,
                `accountId`:string,
                `arn`:string,
                `invokedBy`:string,
                `principalId`:string,
                `sessionContext`:struct<
                    `attributes`:struct<
                        `creationDate`:string,
                        `mfaAuthenticated`:string>,
                    `ec2RoleDelivery`:string,
                    `sessionIssuer`:struct<
                        `accountId`:string,
                        `arn`:string,
                        `principalId`:string,
                        `type`:string,
                        `userName`:string>>,
                `type`:string>,
            `vpcEndpointId`:string>>)

PARTITIONED BY (`region` string, `dt` string)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES ('ignore.malformed.json' = 'true')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://slalommelbtrail/AWSLogs/747843067444/CloudTrail/'

-- ALTER TABLE cloudtrail_raw.cloudtrail_event add partition (region='ap-southeast-2', dt='2020-10-08')
-- location 's3://slalommelbtrail/AWSLogs/747843067444/CloudTrail/ap-southeast-2/2020/10/08'