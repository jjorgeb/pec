# /bin/bash

echo RELOAD

cd /workspace/django-boilerplate
cp app/core/settings/gitpod.py app/core/django-boilerplate/gitpod-tmp.py

echo "# /bin/bash
" > .gitpod/env.sh

cat .docker/app/.env | while read -r line
do
    [ -z "$line" ] && continue
    echo "export $line" >> .gitpod/env.sh
done
chmod +x .gitpod/env.sh

export GITPOD_HOST=`gp url | sed "s|https://||"`
sed -i "s|GITPOD_HOST|8000-$GITPOD_HOST|g" app/core/settings/gitpod-tmp.py
sed -i "s|GITPOD_URL|https://8000-$GITPOD_HOST|g" app/core/settings/gitpod-tmp.py
sed -i "s|core.settings.production|core.settings.gitpod-tmp|g" .gitpod/env.sh
sed -i "s|http://localhost:8000|https://8000-$GITPOD_HOST|g" .gitpod/env.sh
source .gitpod/env.sh

psql -U gitpod -c "DROP DATABASE boilerplate"
psql -U gitpod -c "CREATE DATABASE boilerplate"

cd /workspace/django-boilerplate/app
python manage.py migrate
make loaddata
