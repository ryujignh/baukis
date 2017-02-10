require 'spec_helper'

describe 'Routing' do
  example 'Staff top page' do
    expect(get: 'http://baukis.example.com').to route_to(
      host: 'baukis.example.com',
      controller: 'staff/top',
      action: 'index',
    )
  end

  example 'Admin login form' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
      host: 'baukis.example.com',
      controller: 'admin/sessions',
      action: 'new',
      )
  end

  example 'Customer top page' do
    expect(get: 'http://baukis.example.com/mypage').to route_to(
      host: 'baukis.example.com',
      controller: 'customer/top',
      action: 'index'
      )
  end

  example 'redirects to erros/not_found if no path found' do
    expect(get: 'http://foo.example.jp').to route_to(
      controller: 'errors',
      action: 'routing_error'
      )
  end

  example 'redirects to errors/not_found if no host name found' do
    expect(get: 'http://baukis.example.com/xyz').to route_to(
      controller: 'errors',
      action: 'routing_error',
      anything: 'xyz'
      )
  end

end