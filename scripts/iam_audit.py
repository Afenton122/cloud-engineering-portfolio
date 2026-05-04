"""
IAM Security Audit Script
Lists all IAM users and their attached policies.
Useful for identifying over-privileged identities and enforcing least-privilege review.
"""

import boto3
from datetime import datetime

def audit_iam_users():
    iam = boto3.client("iam")
    users = iam.list_users()["Users"]

    if not users:
        print("No IAM users found.")
        return

    print(f"\nIAM User Audit — {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)

    for user in users:
        username = user["UserName"]
        created = user["CreateDate"].strftime("%Y-%m-%d")
        print(f"\nUser: {username} (Created: {created})")

        attached = iam.list_attached_user_policies(UserName=username)["AttachedPolicies"]
        if attached:
            for policy in attached:
                print(f"  - Attached Policy: {policy['PolicyName']}")
        else:
            print("  - No attached policies")

        inline = iam.list_user_policies(UserName=username)["PolicyNames"]
        if inline:
            for policy in inline:
                print(f"  - Inline Policy: {policy}")

    print("\n" + "=" * 60)
    print("Audit complete.")

if __name__ == "__main__":
    audit_iam_users()