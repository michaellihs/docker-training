import os
print '***** Docker Secrets *****'
print 'USERNAME: {0}'.format(os.environ['USERNAME'])

fname = os.environ['PASSWORD_FILE']
f = open(fname)
try:
  content = f.readlines()
finally:
  f.close

print 'PASSWORD_FILE: {0}'.format(fname)
print 'PASSWORD: {0}'.format(content[0])
