require 'chefspec'
require 'chefspec/cacher'
require 'chefspec/policyfile'

describe 'redhat::default' do
  context "node['redhat']['enable_epel'] = true" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0') do |node|
        node.set['redhat']['enable_epel'] = true
      end.converge('redhat::default')
    end
    it { expect(chef_run).to include_recipe 'yum::default' }
    it { expect(chef_run).not_to include_recipe 'yum-amazon::default' }
    it { expect(chef_run).to include_recipe 'yum-centos::default' }
    it { expect(chef_run).to include_recipe 'yum-epel::default' }
  end

  context 'redhat-7.1 with default node attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'redhat', version: '7.1').converge('redhat::default')
    end
    it { expect(chef_run).to include_recipe 'yum::default' }
    it { expect(chef_run).not_to include_recipe 'yum-amazon::default' }
    it { expect(chef_run).not_to include_recipe 'yum-centos::default' }
    it { expect(chef_run).not_to include_recipe 'yum-epel::default' }
  end

  context 'centos-7.1 with default node attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0').converge('redhat::default')
    end
    it { expect(chef_run).to include_recipe 'yum::default' }
    it { expect(chef_run).not_to include_recipe 'yum-amazon::default' }
    it { expect(chef_run).to include_recipe 'yum-centos::default' }
    it { expect(chef_run).not_to include_recipe 'yum-epel::default' }
  end
end
