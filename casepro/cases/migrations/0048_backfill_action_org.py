# Generated by Django 2.0.8 on 2018-08-21 22:22

from django.db import migrations, transaction
from dash.utils import chunks


def backfill_action_org(apps, schema_editor):
    Case = apps.get_model('cases', 'Case')

    total_cases = Case.objects.count()
    num_updated = 0

    print(f"Found {total_cases} to update actions for...")

    for case_batch in chunks(Case.objects.all(), 1000):
        with transaction.atomic():
            for case_ in case_batch:
                case_.actions.update(org=case_.org)
                num_updated += 1

        print(f" > Updated {num_updated} cases of {total_cases}")



class Migration(migrations.Migration):

    atomic = False

    dependencies = [
        ('cases', '0047_caseaction_org'),
    ]

    operations = [
        migrations.RunPython(backfill_action_org)
    ]
