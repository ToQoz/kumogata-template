require 'abstract_unit'

class Ec2VpcPeeringConnectionTest < Minitest::Test
  def test_normal
    template = <<-EOS
_ec2_vpc_peering_connection "test", ref_peer_vpc: "test", ref_vpc: "test"
    EOS
    act_template = run_client_as_json(template)
    exp_template = <<-EOS
{
  "TestVpcPeeringConnection": {
    "Type": "AWS::EC2::VPCPeeringConnection",
    "Properties": {
      "PeerVpcId": {
        "Ref": "TestVpc"
      },
      "Tags": [
        {
          "Key": "Name",
          "Value": {
            "Fn::Join": [
              "-",
              [
                {
                  "Ref": "Service"
                },
                "test"
              ]
            ]
          }
        },
        {
          "Key": "Service",
          "Value": {
            "Ref": "Service"
          }
        },
        {
          "Key": "Version",
          "Value": {
            "Ref": "Version"
          }
        }
      ],
      "VpcId": {
        "Ref": "TestVpc"
      }
    }
  }
}
    EOS
    assert_equal exp_template.chomp, act_template
  end
end
