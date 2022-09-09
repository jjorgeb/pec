# /bin/bash

echo INIT

git submodule sync
git submodule foreach git checkout main
git submodule foreach git pull

cd /workspace/django-boilerplate
cp app/core/settings/gitpod.py app/core/settings/gitpod-tmp.py

echo "# /bin/bash
" > .gitpod/env.sh

cat .docker/app/.env | while read -r line
do
    [ -z "$line" ] && continue
    echo "export $line" >> .gitpod/env.sh
done
chmod +x .gitpod/env.sh

rm /workspace/django-boilerplate/app/sso
ln -s /workspace/django-boilerplate/django_sso/app/sso /workspace/django-boilerplate/app/sso

export GITPOD_HOST=`gp url | sed "s|https://||"`
sed -i "s|GITPOD_HOST|8000-$GITPOD_HOST|g" app/core/settings/gitpod-tmp.py
sed -i "s|GITPOD_URL|https://8000-$GITPOD_HOST|g" app/core/settings/gitpod-tmp.py
sed -i "s|core.settings.production|core.settings.gitpod-tmp|g" .gitpod/env.sh
sed -i "s|http://localhost:8000|https://8000-$GITPOD_HOST|g" .gitpod/env.sh
source .gitpod/env.sh

psql -U gitpod -c "SELECT 1 FROM pg_database WHERE datname = 'boilerplate'" | grep -q 1 || psql -U gitpod -c "CREATE DATABASE boilerplate"

cd /workspace/django-boilerplate/app
python manage.py migrate
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', '', 'admin')" | python manage.py shell

make loaddata
