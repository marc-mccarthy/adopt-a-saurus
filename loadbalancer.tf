resource "aws_lb" "dino-aws-lb" {
  name               = "dino-aws-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  enable_deletion_protection = false
  tags = local.common_tags
}

resource "aws_lb_target_group" "dino-aws-lb-target-group" {
  name     = "dino-aws-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  tags = local.common_tags
}

resource "aws_lb_listener" "dino-aws-lb-listener" {
  load_balancer_arn = aws_lb.dino-aws-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dino-aws-lb-target-group.arn
  }
  tags = local.common_tags
}

resource "aws_lb_target_group_attachment" "dino-littlefoot-aws-lb-tga" {
  target_id        = aws_instance.dino-littlefoot-website.id
  target_group_arn = aws_lb_target_group.dino-aws-lb-target-group.arn
  port             = 80
}

resource "aws_lb_target_group_attachment" "dino-petrie-aws-lb-tga" {
  target_id        = aws_instance.dino-petrie-website.id
  target_group_arn = aws_lb_target_group.dino-aws-lb-target-group.arn
  port             = 80
}

resource "aws_lb_target_group_attachment" "dino-ducky-aws-lb-tga" {
  target_id        = aws_instance.dino-ducky-website.id
  target_group_arn = aws_lb_target_group.dino-aws-lb-target-group.arn
  port             = 80
}
