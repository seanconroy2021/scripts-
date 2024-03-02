TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Start building the HTML content
echo '<!DOCTYPE html>' > index.html
echo'<html>
<head>
    <title>EC2 Instance Information</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { margin: 20px 0; }
        .header { color: #333366; margin: 20px 0; }
        .image { text-align: center; margin-top: 20px; }
    </style>
</head>
<body>
    <h1 class="header">EC2 Instance Information</h1>' >> index.html
    
    
 # Append the Private IP address
echo '<div class="container"> <strong>Private IP Address:</strong> ' >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4 >> index.html

# Append the Public IP address
echo '<div class="container"> <strong>Public IP Address:</strong> ' >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4 >> index.html

# Append the Instance ID
echo '<div class="container"> <strong>Instance ID:</strong> ' >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id >> index.html

# Append the Instance Type
echo '<div class="container"> <strong>Instance Type:</strong> ' >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-type >> index.html

# Append the Availability Zone
echo '<div class="container"> <strong>Availability Zone:</strong> ' >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone >> index.html

# Append the AMI ID
echo '<div class="container">
        <strong>AMI ID:</strong> ' >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/ami-id >> index.html

# Append a placeholder for the EC2 image
echo '<div class="image">
        <img src="https://miro.medium.com/v2/resize:fit:720/1*icemCezVMahlyIQB31tzpA.png" alt="EC2 Image" style="width:50%;">
    </div>
</body>
</html>' >> index.html
